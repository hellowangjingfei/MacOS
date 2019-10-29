//
//  PresentAnimator.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/15.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "PresentAnimator.h"


@interface PresentAnimator ()<NSViewControllerPresentationAnimator>


@end

@implementation PresentAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    
    //这里实现present动画的效果
    NSView *fromView = fromViewController.view;
    
    CGRect rect = fromView.frame;
    
    NSView *toView = viewController.view;
    CGFloat width = 20;
    CGFloat height = 20 / CGRectGetWidth(rect) * CGRectGetHeight(rect);
    toView.frame = CGRectMake((CGRectGetWidth(rect) - width) / 2.0, (CGRectGetHeight(rect) - height) / 2.0, 10 , height);
    
    [fromView addSubview:toView];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 1.5;
        [[viewController.view animator] setFrame:rect];
    } completionHandler:^{
        
    }];
}
- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    //这里实现dismiss时的动画效果
//    CGRect rect = viewController.view.frame;
//    CGFloat width = CGRectGetWidth(rect);
//    CGFloat height = CGRectGetHeight(rect);
//    CGFloat toWidth = 20;
//    CGFloat toHeight = 20 / width * height;
//    //执行动画
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 1.5;
//        [[viewController.view animator] setFrame:CGRectZero];
    } completionHandler:^{
        //动画完成之后，移除子视图
        [viewController.view removeFromSuperview];
    }];
}
@end
