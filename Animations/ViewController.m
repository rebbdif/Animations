//
//  ViewController.m
//  Animations
//
//  Created by iOS-School-1 on 03.06.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *shakeButton;

@property (nonatomic, strong) UIView *rectangle;
@property (nonatomic, assign) CGRect frame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.frame = self.view.frame;
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_frame) / 2 - 20, 40, 40)];
    self.leftButton.backgroundColor = [UIColor greenColor];
    [self.leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame) - 60, CGRectGetHeight(_frame) / 2 - 20, 40, 40)];
    self.rightButton.backgroundColor = [UIColor greenColor];
    [self.rightButton addTarget:self action:@selector(rigthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    
    self.shakeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)/2-20, CGRectGetHeight(_frame)  - 80, 40, 40)];
    self.shakeButton.backgroundColor = [UIColor greenColor];
    [self.shakeButton addTarget:self action:@selector(shake:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shakeButton];
    
    CGRect rectangleRect = CGRectMake(CGRectGetWidth(_frame) / 2 - 10, CGRectGetHeight(_frame) / 2 - 10, 20, 20);
    self.rectangle = [[UIView alloc] initWithFrame:rectangleRect];
    self.rectangle.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.rectangle];
    
}

- (IBAction)leftButtonPressed:(id)sender {
    [self.rectangle layoutIfNeeded];
    
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 45);
    }];
    
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.alpha = 0;
    }];
    
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.center = CGPointMake(0, CGRectGetHeight(_frame)/2);
    }];
    
}

- (IBAction)rigthButtonPressed:(id)sender {
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
    }];
    
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.alpha = 1;
    }];
    [UIView animateWithDuration:3 animations:^{
        self.rectangle.center = CGPointMake(CGRectGetWidth(_frame) / 2 - 10, CGRectGetHeight(_frame)/2);
    }];
    [self rotate];
}

- (IBAction)shake:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    [self.rectangle.layer addAnimation:animation forKey:@"shake"];
}

- (void)rotate {
    CGRect boundingRect = CGRectMake(-150, -150, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.rectangle.layer addAnimation:orbit forKey:@"orbit"];
}

@end
