//
//  ViewController.m
//  AnimationDemo
//
//  Created by JayZY on 15/10/19.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()
{
    UIView *_roundRview;
    UIView *_syncImageView;

}
@property (nonatomic,assign) CGFloat angle;
@property (nonatomic,strong) UIView *saomiao;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =[ UIColor whiteColor];
    //绘制一个圆进行逆时针旋转
//    [self drawRoundRotation];
//    //
//    [self drawaRojund];
    //
    self.saomiao = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    self.saomiao.layer.cornerRadius = 10.0;
    self.saomiao.layer.masksToBounds = YES;
    self.saomiao.backgroundColor =  [UIColor greenColor];
    [self.view addSubview:self.saomiao];
    [self startAnimation];
}

-(void)startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startAnimation)];
    self.angle += 10;
    self.saomiao.layer.anchorPoint = CGPointMake(0.5,0.5);//以右下角为原点转，（0,0）是左上角转，（0.5,0,5）心中间转，其它以此类推
    /*正的顺时针,负的逆时针*/
    self.saomiao.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView commitAnimations];

}


- (void)drawaRojund
{
    CustomView *myView =[[CustomView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    myView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:myView];
    
    
    
    
}


- (void)drawRoundRotation
{
    /** 绘制一个圆*/
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    roundView.layer.cornerRadius = 40.0f;
    roundView.layer.masksToBounds = YES;
    roundView.backgroundColor = [UIColor greenColor];
    _roundRview = roundView;
    [self.view addSubview:_roundRview];
    UIView *centerView =[[UIView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    centerView.backgroundColor = [UIColor redColor];
    [_roundRview addSubview:centerView];
    /**圆的逆时针旋转*/
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = [NSNumber numberWithFloat: M_PI*2.0];
    rotation.duration = 1.0;
    rotation.cumulative = YES;
    rotation.repeatCount = 5.0;
    rotation.delegate = self;
    rotation.fillMode = kCAFillModeRemoved;
    //
    CALayer *layer = [[CALayer alloc] init];
    layer.contents = _roundRview.layer.contents;
    layer.frame = _roundRview.frame;
    layer.opacity = 1.0f;
    [self.view.layer addSublayer:layer];
    
    [layer addAnimation:rotation forKey:@"rotation"];
  //
    CGPoint startPoint = self.view.center;
//    [self.view convertPoint:self.bottomToolBar.btnAddToCart.center fromView:self.bottomToolBar];
    
    roundView.center = startPoint;
    //动画 终点 都以sel.view为参考系
    CGPoint endpoint = self.view.center;
    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    //动画起点
    [bezierPath  moveToPoint:startPoint];
    
    //贝塞尔曲线控制点
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endpoint.x;
    float ey = endpoint.y;
    float x = sx + (ex - sx) / 3.0;
    float y = sy + (ey - sy) * 0.5 -200;
    CGPoint centerPoint=CGPointMake(x, y);
    [bezierPath  addQuadCurveToPoint:endpoint controlPoint:startPoint];
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path =bezierPath.CGPath;
    animation.removedOnCompletion = NO;
    //    animation.rotationMode = kCAAnimationDiscrete;//额外增加
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 10.0;
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:animation forKey:@"roundRotation"];

}

- (void)animationDidStart:(CAAnimation *)anim
{
//    _roundRview.frame =CGRectMake(_roundRview.frame.origin.x, _roundRview.frame.origin.y, _roundRview.frame.size.width+5, _roundRview.frame.size.height+5);
    _roundRview.transform = CGAffineTransformMakeRotation(_roundRview.frame.size.width/2);
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _roundRview.backgroundColor = [UIColor brownColor];
    _roundRview.transform = CGAffineTransformIdentity;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
