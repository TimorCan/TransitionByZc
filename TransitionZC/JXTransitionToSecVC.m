
//
//  JXTransitionToSecVC.m
//  TransitionZC
//
//  Created by juxi-ios on 16/1/11.
//  Copyright © 2016年 周灿. All rights reserved.
//

#import "JXTransitionToSecVC.h"
#import "ViewController.h"
#import "SecViewController.h"
#import "MyCell.h"



@implementation JXTransitionToSecVC



-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为source ViewController

    ViewController * fromViewController = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 可以看做为destination ViewController
    SecViewController *toViewController = (SecViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //容器
    UIView * containerView = [transitionContext containerView];
    //转场时间
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //获得fromViewC 的cell
    
    
    
    MyCell * cell = (MyCell *)[fromViewController.collectionView cellForItemAtIndexPath:[[fromViewController.collectionView indexPathsForSelectedItems] firstObject]];
     //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    //截图大法start
    UIView * tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    
//    tempView.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    
    
     tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView: containerView];
    
    
   //原来的可以隐藏 现在是显示截图
    cell.imageView.hidden = YES;
    toViewController.view.alpha = 0 ;
    toViewController.imageViewSec.hidden = YES;
    
    
    //截图要保持在最上面
    [containerView addSubview:toViewController.view];
    [containerView addSubview:tempView];
    
    //开始做动画
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        
//        // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
//        - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
//        // 将rect从view中转换到当前视图中，返回在当前视图中的rect
//        - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
        
        
        
//        CGRect frame = [containerView convertRect:toViewController.imageViewSec.frame fromView:toViewController.view];
//        tempView.frame = frame;
        tempView.frame = [toViewController.imageViewSec convertRect:toViewController.imageViewSec.bounds toView:containerView];
         toViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        //动画结束
        tempView.hidden = YES;
        toViewController.imageViewSec.hidden = NO;
        cell.imageView.hidden = NO;
        //声明动画完成
        [transitionContext completeTransition:YES];

    }];
    
    
}


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.75;
}


@end
