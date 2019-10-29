//
//  ExampleTabViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/16.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "ExampleTabViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ExampleTabViewController ()

@end

@implementation ExampleTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //设置显示在顶部
    /*
     NSTabViewControllerTabStyleSegmentedControlOnTop = 0,
     NSTabViewControllerTabStyleSegmentedControlOnBottom,
     NSTabViewControllerTabStyleToolbar,
     NSTabViewControllerTabStyleUnspecified = -1,
     */
    self.tabStyle = NSTabViewControllerTabStyleSegmentedControlOnTop;
    self.canPropagateSelectedChildViewControllerTitle = NO;

    [self createSubviewsUI];
}

#pragma mark -Create UI
- (void)createSubviewsUI {

    FirstViewController *firstViewCtrl = [[FirstViewController alloc] init];
    NSTabViewItem *firstItem = [NSTabViewItem tabViewItemWithViewController:firstViewCtrl];
    firstItem.label = @"one";
    firstItem.identifier = @"FirstViewController";
    [self addTabViewItem:firstItem];
    
    SecondViewController *secondViewCtrl = [[SecondViewController alloc] init];
    NSTabViewItem *secondItem = [NSTabViewItem tabViewItemWithViewController:secondViewCtrl];
    secondItem.label = @"two";
    secondItem.identifier = @"SecondViewController";
    [self addTabViewItem:secondItem];
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    
}
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    [super tabView:tabView didSelectTabViewItem:tabViewItem];
    
    NSLog(@"tabViewItem ------- %@",tabViewItem.label);

}
@end
