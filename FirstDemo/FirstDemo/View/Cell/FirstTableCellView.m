//
//  FirstTableCellView.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/9.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "FirstTableCellView.h"
#import "Masonry.h"

@interface FirstTableCellView ()

//名称
@property (nonatomic,strong) NSTextField  *nameTextField;

//图片
@property (nonatomic,strong) NSImageView  *imgView;

@end

@implementation FirstTableCellView

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
    
    //名称
    _nameTextField = [[NSTextField alloc] init];
    _nameTextField.font = [NSFont systemFontOfSize:12];
    _nameTextField.alignment = NSTextAlignmentLeft;
    _nameTextField.bordered = NO;
    _nameTextField.lineBreakMode = NSLineBreakByClipping;
    _nameTextField.maximumNumberOfLines = 0;
    /*
     NSWritingDirectionNatural       = -1,
     NSWritingDirectionLeftToRight   = 0,
     NSWritingDirectionRightToLeft
     */
    _nameTextField.baseWritingDirection = NSWritingDirectionRightToLeft;
    _nameTextField.usesSingleLineMode = YES;
    [self addSubview:_nameTextField];
    
    //图片
    
    _imgView = [[NSImageView alloc] init];
    _imgView.wantsLayer = YES;
//    _imgView.layer.backgroundColor = [NSColor redColor].CGColor;
//    _imgView.image = [NSImage imageNamed:<#(nonnull NSImageName)#>];
    [self addSubview:_imgView];
    
    [self makeUIConstraints];
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    
    //图片
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //名称
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
    }];
    
}
- (void)setDataModel:(FirstDataModel *)dataModel {

    _dataModel = dataModel;

    _nameTextField.stringValue = _dataModel.nameTitle;

    if (!_dataModel.imageName) {
        //图片
        _imgView.layer.backgroundColor = _dataModel.imgColor.CGColor;
    }else{
        _imgView.image = _dataModel.imageName;
    }
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
