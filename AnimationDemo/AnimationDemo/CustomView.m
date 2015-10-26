//
//  CustomView.m
//  AnimationDemo
//
//  Created by JayZY on 15/10/19.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>

 #define PI 3.14159265358979323846

@implementation CustomView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;

}

- (void)drawRect:(CGRect)rect
{
   //
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    UIFont *font =[UIFont boldSystemFontOfSize:15.0f];
    [@"画图" drawInRect:CGRectMake(10, 20, 80, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]}];
    CGContextSetRGBStrokeColor(context, 0, 0, 0.5, 1.0);
    CGContextSetLineWidth(context, 1.0);
    ////void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 100, 30, 30, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    // 画线
    CGPoint aPoint[2];
    aPoint[0] =CGPointMake(20, 80);
    aPoint[1]  =CGPointMake(130, 80);
    CGContextAddLines(context, aPoint, 2);
    CGContextDrawPath(context, kCGPathFillStroke);
    // 画圆弧
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 0.9);
    CGContextMoveToPoint(context, 140, 80);
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 160, 80);
    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
    CGContextDrawPath(context, kCGPathStroke);
    /**画矩形 */
    CGContextStrokeRect(context, CGRectMake(100, 120, 10, 10));
    
    CGContextFillRect(context, CGRectMake(120, 120, 10, 10));
    
    CGContextAddRect(context, CGRectMake(140, 120, 60, 30));

    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    /**图形颜色渐变 */
    CAGradientLayer *gradientLayer =[CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(240, 120, 60, 30);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,[UIColor greenColor].CGColor,[UIColor redColor].CGColor,[UIColor orangeColor].CGColor,[UIColor yellowColor].CGColor, nil];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    /**一个颜色渐变的圆*/
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
    /**画扇形以及椭圆*/
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:1 blue:1 alpha:1].CGColor);
    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 160, 180, 30, -60*PI/180.0, -120*PI/180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    /*画椭圆*/
    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8));
    CGContextDrawPath(context, kCGPathFillStroke);
    /*画三角形*/
    CGPoint sPoints[3];
    sPoints[0] =CGPointMake(100, 220);//坐标1
    sPoints[1] =CGPointMake(130, 220);//坐标2
    sPoints[2] =CGPointMake(130, 160);//坐标3
    CGContextAddLines(context, sPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    /*画贝塞尔曲线*/
    CGContextMoveToPoint(context, 100, 300);
    CGContextAddQuadCurveToPoint(context, 190, 310, 120, 390);
    CGContextStrokePath(context);
    
    /*画圆角矩形*/
    float fw = 180;
    float fh = 280;
    
    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
     /*图片绘图*/
    self.img=[UIImage imageNamed:@"002"];
    
    [self.img drawInRect:CGRectMake(60, 340, self.img.size.width  , self.img.size.height)];
    CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), self.img.CGImage);
    
//    CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), img.CGImage);//平铺图
    
    
}

@end
