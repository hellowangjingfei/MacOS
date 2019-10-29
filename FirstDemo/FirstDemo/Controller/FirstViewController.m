//
//  FirstViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/9.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "FirstViewController.h"
#import "Masonry.h"
#import "FirstCollectionViewItem.h"

@interface FirstViewController ()<NSCollectionViewDelegate,NSCollectionViewDataSource>

//标题
@property (nonatomic,strong) NSTextField       *titleTextField;
//退出按钮
@property (nonatomic,strong) NSButton          *exitButton;

@property (nonatomic,strong) NSScrollView      *scrollView;

@property (nonatomic,strong) NSCollectionView  *collectionView;

@property (nonatomic,strong) NSMutableArray    *dataArrayM;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self createSubviewsUI];
}
- (void)loadView {
    
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor orangeColor].CGColor;
    
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    //标题
    _titleTextField = [[NSTextField alloc] init];
    _titleTextField.editable = NO;
    _titleTextField.stringValue = @"这是Popover view";
    [self.view addSubview:_titleTextField];
    
    _scrollView = [[NSScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.backgroundColor = [NSColor redColor];
    //滚动条 --- 垂直
    _scrollView.hasVerticalScroller = NO;
    //滚动条 --- 水平
    _scrollView.hasHorizontalScroller = NO;
    //自动隐藏滚动条（滚动的时候出现）
    
    _scrollView.autohidesScrollers = NO;
    
    [self.view addSubview:_scrollView];
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((200 - 50) / 3.0, 50);
    flowLayout.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    _collectionView = [[NSCollectionView alloc] initWithFrame:CGRectZero];
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //是否可以点击
    _collectionView.selectable = YES;
    
    _scrollView.documentView = _collectionView;
    
    [_collectionView registerClass:[FirstCollectionViewItem class] forItemWithIdentifier:@"FirstCollectionViewItem"];
    
    //退出按钮
    _exitButton = [NSButton buttonWithTitle:@"退出" target:self action:@selector(exitButtonClick:)];
    [self.view addSubview:_exitButton];
    
    [self makeUIConstraints];
}

#pragma mark -Constraints
- (void)makeUIConstraints {
    
    //标题
    [_titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX).mas_offset(0);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.titleTextField.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(200);
        make.bottom.mas_equalTo(self.exitButton.mas_top).mas_offset(-10);
    }];
    
    //退出按钮
    [_exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
}
#pragma mark -NSCollectionViewDelegate,NSCollectionViewDataSource
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}
- (nonnull NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstCollectionViewItem *item = [collectionView makeItemWithIdentifier:@"FirstCollectionViewItem" forIndexPath:indexPath];
    item.labelName.stringValue = [NSString stringWithFormat:@"%ld",indexPath.item];
    return item;
}
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
    NSLog(@"click --- %ld",[indexPaths anyObject].item);
}
#pragma mark -Click Method
- (void)exitButtonClick:(NSButton *)button {
    
    [[NSApplication sharedApplication] terminate:self];
}
@end
