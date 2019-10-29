//
//  SecondViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/13.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"

@interface SecondViewController ()<NSTextViewDelegate>

//左边
@property (nonatomic,strong) NSTextView  *leftTextView;

//复制按钮
@property (nonatomic,strong) NSButton    *cy_Button;

//转换按钮
@property (nonatomic,strong) NSButton    *changeButton;

//清空按钮
@property (nonatomic,strong) NSButton    *clearButton;

//返回按钮
@property (nonatomic,strong) NSButton    *returnButton;

//右边
@property (nonatomic,strong) NSTextView  *rightTextView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self createSubviewsUI];
}
- (void)loadView {
    
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor purpleColor].CGColor;
    
}

#pragma mark -Create UI
- (void)createSubviewsUI {
    
    //左边
    _leftTextView = [self createTextView];
    [self.view addSubview:_leftTextView];
    
    //复制按钮
    _cy_Button = [self createButton];
    _cy_Button.title = @"复制";
    [self.view addSubview:_cy_Button];
    
    //转换按钮
    _changeButton = [self createButton];
    _changeButton.title = @"转换";
    [self.view addSubview:_changeButton];
    
    //清空按钮
    _clearButton = [self createButton];
    _clearButton.title = @"清空";
    [self.view addSubview:_clearButton];
    
    //返回按钮
    _returnButton = [self createButton];
    _returnButton.title = @"返回";
    [self.view addSubview:_returnButton];
    
    //右边
    _rightTextView = [self createTextView];
    [self.view addSubview:_rightTextView];
    
    [self makeUIConstraints];
}

- (NSTextView *)createTextView {
    
    NSTextView *textView = [[NSTextView alloc] init];
    //这个很重要，不然熟知的的英文引号会自动变为中文的引号，导致字符串解析错误
    textView.automaticQuoteSubstitutionEnabled = NO;
    textView.delegate = self;
    return textView;
}
- (NSButton *)createButton {
    
    NSButton *button = [NSButton buttonWithTitle:@"" target:self action:@selector(buttonClick:)];
    
    return button;
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    CGFloat width = (CGRectGetWidth(frame) - 150) / 2.0;
    //左边
    [_leftTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-10);
        make.width.mas_equalTo(width);
    }];
    
    //复制按钮
    [_cy_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
        make.bottom.mas_equalTo(self.changeButton.mas_top).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    //转换按钮
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-12.5);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    //清空按钮
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(12.5);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    //返回按钮
    [_returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
        make.top.mas_equalTo(self.clearButton.mas_bottom).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    //右边
    [_rightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-10);
        make.width.mas_equalTo(width);
    }];
}
#pragma mark -NSTextViewDelegate

#pragma mark -Click method
- (void)buttonClick:(NSButton *)button {
    
    
    if (button == _cy_Button) {
        
        if (_leftTextView.string.length == 0 || _leftTextView.string == nil) {
            return;
        }
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        NSArray *typesArray = [pasteboard types];
        
        [pasteboard clearContents];
        
        if ([typesArray containsObject:NSPasteboardTypeString]) {
            [pasteboard setString:_leftTextView.string forType:NSPasteboardTypeString];
        }
    }else if (button == _changeButton) {
        if (_leftTextView.string.length != 0 && _leftTextView.string != nil) {
            [self changeJsonDataToDic];
        }
    }else if (button == _clearButton) {
        _leftTextView.string = @"";
        _rightTextView.string = @"";
    }else if (button == _returnButton) {
//        [self.presentingViewController dismissViewController:self];
        [self.view.window close];
    }
}

//转换数据
- (void)changeJsonDataToDic {
    
    NSString *jsonStr = _leftTextView.string;
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (!error) {
        if (jsonDic.count > 0) {
//            NSArray *arr = [jsonDic allKeys];
            _rightTextView.string = [NSString stringWithFormat:@"%@",jsonDic];
        }
    }else{
        NSLog(@"error ------- %@",[error description]);
    }
}
@end
