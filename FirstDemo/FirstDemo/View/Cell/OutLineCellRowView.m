//
//  OutLineCellRowView.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/14.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "OutLineCellRowView.h"
#import "Masonry.h"
#import "OutLineDataModel.h"


@interface OutLineCellRowView ()

@property (nonatomic,strong) NSTextField  *nodeNameTextField;

@end

@implementation OutLineCellRowView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviewsUI];
    }
    return self;
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    _nodeNameTextField = [[NSTextField alloc] init];
    _nodeNameTextField.editable = NO;
    [self addSubview:_nodeNameTextField];
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    [_nodeNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).mas_offset(NSEdgeInsetsZero);
    }];
}
- (void)setObjectValue:(id)objectValue {
    
    [super setObjectValue:objectValue];
    
    if ([objectValue isKindOfClass:[OutLineDataModel class]]) {
        OutLineDataModel *dataModel = (OutLineDataModel *)objectValue;
        
        _nodeNameTextField.stringValue = dataModel.nodeName;
    }
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
