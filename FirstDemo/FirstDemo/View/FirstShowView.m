//
//  FirstShowView.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/9.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "FirstShowView.h"
#import "Masonry.h"


@interface FirstShowView ()

@property (nonatomic,copy) NSString  *name;

//第一个标题
@property (nonatomic,strong) NSTextField  *titleFirstLabel;
//内容
@property (nonatomic,strong) NSTextField  *contentTextField;
//第二个标题
@property (nonatomic,strong) NSTextField  *titleSecondLabel;
//显示星级
@property (nonatomic,strong) NSTextField  *starTextField;
//图片
@property (nonatomic,strong) NSImageView  *imgView;

@end

@implementation FirstShowView

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
    
    //第一个标题
    _titleFirstLabel = [self createTextField];
    _titleFirstLabel.textColor = [NSColor grayColor];
    _titleFirstLabel.stringValue = @"Name";
    _titleFirstLabel.bordered = NO;
    _titleFirstLabel.drawsBackground = NO;
    _titleFirstLabel.editable = NO;
    [self addSubview:_titleFirstLabel];
    
    //内容
    _contentTextField = [self createTextField];
    _contentTextField.backgroundColor = [NSColor whiteColor];
    [self addSubview:_contentTextField];
    
    //第二个标题
    _titleSecondLabel = [self createTextField];
    _titleSecondLabel.textColor = [NSColor grayColor];
    _titleSecondLabel.stringValue = @"Rating";
    _titleSecondLabel.drawsBackground = NO;
    _titleSecondLabel.bordered = NO;
    _titleSecondLabel.editable = NO;
    [self addSubview:_titleSecondLabel];
    
    //显示星级
    _starTextField = [self createTextField];
    [self addSubview:_starTextField];
    
    //图片
    _imgView = [[NSImageView alloc] init];
    _imgView.animates = YES;
    _imgView.editable = YES;
    _imgView.image = [NSImage imageNamed:@"timg.gif"];
    [self addSubview:_imgView];
    
    [self makeUIConstraints];
}
- (NSTextField *)createTextField {
    
    NSTextField *textF = [[NSTextField alloc] init];
    textF.font = [NSFont systemFontOfSize:13];
    textF.textColor = [NSColor blackColor];
//    textF.editable = NO;
    return textF;
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    //第一个标题
    [_titleFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.mas_top).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    //内容
    [_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.titleFirstLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    //第二个标题
    [_titleSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.contentTextField.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    //显示星级
    [_starTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.titleSecondLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    //图片
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.starTextField.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}
- (void)setDataModel:(FirstDataModel *)dataModel {
    
    _dataModel = dataModel;
    
    //内容
    _contentTextField.stringValue = _dataModel.nameTitle;
    
    //显示星级
    _starTextField.stringValue = [NSString stringWithFormat:@"%ld",_dataModel.score];

    if (!_dataModel.imageName) {
        //图片
        _imgView.layer.backgroundColor = _dataModel.imgColor.CGColor;
    }else{
        _imgView.image = _dataModel.imageName;
    }
}
- (void)removeAllDataSource {
    
    //内容
    _contentTextField.stringValue = @"";
    
    //显示星级
    _starTextField.stringValue = @"";
    
    //图片
    _imgView.layer.backgroundColor = [NSColor clearColor].CGColor;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
