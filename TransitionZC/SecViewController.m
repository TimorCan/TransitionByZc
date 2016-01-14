//
//  SecViewController.m
//  TransitionZC
//
//  Created by juxi-ios on 16/1/11.
//  Copyright © 2016年 周灿. All rights reserved.
//

#import "SecViewController.h"
#import "JXTransitonSecToVC.h"
#import "ViewController.h"
@interface SecViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array = @[
                        @"“不是有人跟我说，那里有片被落日镀金的海滩可以通往时间的尽头吗？我们去走走……”",
                        @"这是开始改变的一周，七天时间或许无法改变很多事情，但是你的身体开始发生正向的改变，跑步的初体验让你的心率加快、血液快速流过全身、身上多余的脂肪开始燃烧。",
                        @"虽然你的双腿会感到酸痛，但是心情却莫名地感到舒畅，因为跑步会促使脑垂体分泌出快乐激素——内啡肽，就像是恋爱的感觉，你会觉得自己能跑得快飞起",
                        @"跑步带给你一天的好心情和更加轻快的人生态度，你觉得沿途的风景都是不一样的。﻿﻿",
                        @"一个月的跑步，你的呼吸变得均匀平稳，心跳变得沉稳有力。你应该已经甩掉了几斤赘肉，慢慢地有些衣服裤子穿上去已经有点大了。"
                        
                        ];
    
    NSString * imageName = [NSString stringWithFormat:@"%ld.jpg",(long)self.selectIndex+1];
     self.imageViewSec.image = [UIImage imageNamed:imageName];
    NSLog(@"%@",NSStringFromCGRect(self.imageViewSec.frame));
     self.label.text = array[self.selectIndex];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[ViewController class]]) {
        return [[JXTransitonSecToVC alloc] init];
    }
    else {
        return nil;
    }
}
@end
