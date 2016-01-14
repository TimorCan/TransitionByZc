//
//  JXTransitonSecToVC.m
//  TransitionZC
//
//  Created by juxi-ios on 16/1/12.
//  Copyright © 2016年 周灿. All rights reserved.
//

#import "JXTransitonSecToVC.h"
#import "ViewController.h"
#import "SecViewController.h"
#import "MyCell.h"

@implementation JXTransitonSecToVC
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 可以看做为source ViewController
    
     SecViewController* fromViewController = (SecViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 可以看做为destination ViewController
    ViewController *toViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //容器
    UIView * containerView = [transitionContext containerView];
    //转场时间
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //获得fromViewC 的cell
    
    
    
    MyCell * cell = (MyCell *)[toViewController.collectionView cellForItemAtIndexPath:toViewController.currentIndexPath];
    
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    //截图大法start
    UIView * tempView = [fromViewController.imageViewSec snapshotViewAfterScreenUpdates:NO];
    
    tempView.frame = [containerView convertRect:fromViewController.imageViewSec.frame fromView:fromViewController.view];
    
    
//    tempView.frame = [toViewController.imag convertRect:cell.imageView.bounds toView: containerView];
    
    
    //原来的可以隐藏 现在是显示截图
    fromViewController.imageViewSec.hidden = YES;
    toViewController.view.alpha = 0 ;
    cell.imageView.hidden = YES;
    
    
    //截图要保持在最上面
    [containerView addSubview:toViewController.view];
    [containerView addSubview:tempView];
    
    //开始做动画
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        
        //        // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
        //        - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
        //        // 将rect从view中转换到当前视图中，返回在当前视图中的rect
        //        - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
        
        
        
         CGRect frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
               tempView.frame = frame;
        
        toViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        //动画结束
        tempView.hidden = YES;
        cell.imageView.hidden = NO;
        fromViewController.imageViewSec.hidden= NO;
//        cell.imageView.hidden = NO;
        //声明动画完成
        [transitionContext completeTransition:YES];
        
    }];
    
    
}


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.75;
}


@end
