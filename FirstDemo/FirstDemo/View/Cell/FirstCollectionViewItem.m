//
//  FirstCollectionViewItem.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/13.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "FirstCollectionViewItem.h"
#import "Masonry.h"

@interface FirstCollectionViewItem ()



@end

@implementation FirstCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    /*
     NSCollectionViewItemHighlightNone = 0,
     NSCollectionViewItemHighlightForSelection = 1,
     NSCollectionViewItemHighlightForDeselection = 2,
     NSCollectionViewItemHighlightAsDropTarget = 3,
     */
//    self.highlightState = NSCollectionViewItemHighlightForSelection;
    [self createSubviewsUI];
}
- (void)loadView {
    
    self.view = [[NSView alloc] initWithFrame:CGRectMake(0, 0, (200 - 50) / 3.0, 50)];
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    _labelName = [[NSTextField alloc] init];
    _labelName.editable = NO;
    _labelName.wantsLayer = YES;
    _labelName.layer.backgroundColor = [NSColor greenColor].CGColor;
    [self.view addSubview:_labelName];
    
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).mas_offset(NSEdgeInsetsZero);
    }];
}
@end
