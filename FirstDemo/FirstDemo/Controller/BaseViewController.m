//
//  BaseViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/14.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (void)loadView {
    
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
    self.preferredContentSize = self.view.frame.size;
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    
}
- (void)dealloc {
    
    NSLog(@"%s",__func__);
}
@end
