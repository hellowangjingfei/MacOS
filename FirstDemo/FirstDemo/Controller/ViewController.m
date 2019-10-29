//
//  ViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/8.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "FirstDataModel.h"
#import "FirstTableCellView.h"
#import "FirstShowView.h"
#import <Quartz/Quartz.h>
#import <AppKit/AppKit.h>
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "TaskViewController.h"
#import "PublicKnowledgePoint.h"
#import "PresentAnimator.h"
#import "ExampleTabViewController.h"


@interface ViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@property (nonatomic,strong) NSTableView     *tableView;

@property (nonatomic,strong) NSScrollView    *scrollView;

//增加
@property (nonatomic,strong) NSButton        *addButton;

//减少
@property (nonatomic,strong) NSButton        *subButton;

//线
@property (nonatomic,strong) NSBox           *verLine;

@property (nonatomic,strong) NSMutableArray  *dataSourceM;

@property (nonatomic,strong) FirstShowView   *showView;

//修改图片
@property (nonatomic,strong) NSButton        *changeButton;

//添加状态栏
@property (nonatomic,strong) NSStatusItem    *statusItem;

//点击状态栏后的弹窗
@property (nonatomic,strong) NSPopover       *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//    [[PublicKnowledgePoint sharedInstance] changeChinaToVoice:@"Hello World"];
//
//    [[PublicKnowledgePoint sharedInstance] addSystemRemindEvent];
   
    [self createSubviewsUI];
    
    [self requestDataSource];
}
- (void)showMyPopover:(NSStatusBarButton *)button {
    
    [_popover showRelativeToRect:_statusItem.view.frame ofView:button preferredEdge:NSMinYEdge];
}
#pragma mark -DataSource
- (void)requestDataSource {
    
    _dataSourceM = [NSMutableArray array];
    
    for (int i = 0; i < 50; i++) {
        FirstDataModel *model = [FirstDataModel new];
        model.nameTitle = [NSString stringWithFormat:@"title----%d",i];
        model.imgColor = [NSColor colorWithSRGBRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1.0];
        model.score = arc4random() % 11;
        [_dataSourceM addObject:model];
    }
    [_tableView reloadData];
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    _tableView = [[NSTableView alloc] initWithFrame:CGRectZero];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //交替色差效果
//    _tableView.usesAlternatingRowBackgroundColors = YES;
//    _tableView.backgroundColor = [NSColor orangeColor];
    //获得焦点时的风格
    /*
     NSFocusRingTypeDefault = 0,
     NSFocusRingTypeNone = 1,
     NSFocusRingTypeExterior = 2
     */
    _tableView.focusRingType = NSFocusRingTypeDefault;
    //行高亮的风格
    /*
     NSTableViewSelectionHighlightStyleNone NS_ENUM_AVAILABLE_MAC(10_6) = -1,
     NSTableViewSelectionHighlightStyleRegular = 0,
     NSTableViewSelectionHighlightStyleSourceList = 1,
     */
    _tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;
    //表头
    _tableView.headerView.frame = NSZeroRect;
    
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"NSTableColumn1"];
    column1.width = 100;
    column1.title = @"第一列";
    [_tableView addTableColumn:column1];

//    NSTableColumn *column2 = [[NSTableColumn alloc] initWithIdentifier:@"NSTableColumn2"];
//    column2.width = 200;
//    column2.title = @"第二列";
//    [_tableView addTableColumn:column2];
    
    //实现tableView的滑动效果
    _scrollView = [[NSScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.documentView = _tableView;
    
    
    //是否画背景
//    scrollView.drawsBackground = YES;
//    scrollView.backgroundColor = [NSColor greenColor];
    
    //滚动条 --- 垂直
    _scrollView.hasVerticalScroller = NO;
    
    //滚动条 --- 水平
    _scrollView.hasHorizontalScroller = NO;
    
    //自动隐藏滚动条（滚动的时候出现）
    _scrollView.autohidesScrollers = YES;
    
    [self.view addSubview:_scrollView];
    
    //添加数据
    _addButton = [self createButton];
    [self.view addSubview:_addButton];
    
    //删除数据
    _subButton = [self createButton];
    _subButton.title = @"-";
    [self.view addSubview:_subButton];
    
    //线
    _verLine = [[NSBox alloc] init];
    /*
     NSNoBorder                = 0,
     NSLineBorder            = 1,
     NSBezelBorder            = 2,
     NSGrooveBorder            = 3
     */
    _verLine.borderType = NSLineBorder;
    /*
     NSBoxPrimary    = 0,    // group subviews with a standard look. default
     NSBoxSecondary    = 1,    // same as primary since 10.3
     NSBoxSeparator    = 2,    // vertical or horizontal separtor line.  Not used with subviews.
     NSBoxOldStyle    = 3,    // 10.2 and earlier style boxes
     NSBoxCustom    NS_ENUM_AV
     */
    _verLine.boxType = NSBoxCustom;

    [self.view addSubview:_verLine];
    
    //展示数据
    _showView = [[FirstShowView alloc] init];
    [self.view addSubview:_showView];
    
    //修改图片
    _changeButton = [self createButton];
    _changeButton.title = @"修改图片";
    [self.view addSubview:_changeButton];
    
    //添加状态栏
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:20];
    NSImage *img = [NSImage imageNamed:@"shockedface2_full"];
    //设置此属性，会自动适配状态背景色
    img.template = YES;
    _statusItem.button.image = img;
    
    _popover = [[NSPopover alloc] init];
    _popover.behavior = NSPopoverBehaviorTransient;
    _popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    _popover.contentViewController = [FirstViewController new];
    //为NSStatusItem添加点击事件
    _statusItem.target = self;
    _statusItem.button.action = @selector(showMyPopover:);
    
    //添加监听事件
    __weak typeof(self) weakSelf = self;
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown handler:^(NSEvent * _Nonnull event) {
        if (weakSelf.popover.isShown) {
            [weakSelf.popover close];
        }
    }];
    
 
    
    [self makeUIConstraints];
}
- (NSButton *)createButton {
    
    NSButton *button = [NSButton buttonWithTitle:@"+" target:self action:@selector(addOrRemoveDataSourceButtonClick:)];
    button.imagePosition = NSNoImage;
    return button;
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-50);
        make.width.mas_equalTo(200);
    }];
    
    //添加数据
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.subButton.mas_left).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //删除数据
    [_subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.scrollView.mas_right).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //线
    [_verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-50);
        make.width.mas_equalTo(1);
    }];
    
    //展示数据
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verLine.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-50);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
    }];

    //修改图片
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.showView.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.showView.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.showView.mas_right).mas_offset(-20);
        make.height.mas_equalTo(25);
    }];
}
#pragma mark -Click Method
- (void)addOrRemoveDataSourceButtonClick:(NSButton *)button {

//    //定义alert变量
//
//    NSAlert *alert = [[NSAlert alloc] init];
//
////    [alert addButtonWithTitle:@"提示"];
//
//    //添加ok按钮
//    [alert addButtonWithTitle:@"OK"];
//    
//    //弹窗内容
//    alert.messageText = @"Hello world";
//
//    //描述性文字
//    alert.informativeText = @"This is my first Mac App.";
//
//    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
//        if (returnCode == NSAlertFirstButtonReturn) {
//            NSLog(@"This is OK button tap");
//        }
//    }];
//
//    return;
    
    if (button == _addButton) {
        
        SecondViewController *secondViewCtrl = [[SecondViewController alloc] init];
//        [self presentViewControllerAsSheet:secondViewCtrl];
        [self presentViewControllerAsModalWindow:secondViewCtrl];
        return;
        FirstDataModel *addModel = [[FirstDataModel alloc] init];
        addModel.nameTitle = [NSString stringWithFormat:@"add Title  --------- %ld",[_dataSourceM count]];
        addModel.imgColor = [NSColor colorWithSRGBRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1.0];
        addModel.score = arc4random() % 11;
        [_dataSourceM addObject:addModel];
        /*
         NSTableViewAnimationEffectNone = 0x0,
         NSTableViewAnimationEffectFade = 0x1,
         NSTableViewAnimationEffectGap = 0x2,
         NSTableViewAnimationSlideUp    = 0x10,
         NSTableViewAnimationSlideDown  = 0x20,
         NSTableViewAnimationSlideLeft  = 0x30,
         NSTableViewAnimationSlideRight = 0x40,
         */
        
        NSInteger index = [_dataSourceM count] - 1;
        [_tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationEffectFade];
        [_tableView scrollRowToVisible:index];
    }else if (button == _subButton) {
        
        ThirdViewController *thirdViewCtrl = [[ThirdViewController alloc] init];
        
//        [self presentViewControllerAsSheet:thirdViewCtrl];
//        /*
//         NSViewControllerTransitionNone                  =    0x0,
//        NSViewControllerTransitionCrossfade             =    0x1,   // Fades the new view in and the old view out.
//        NSViewControllerTransitionSlideUp               =   0x10,   // Animates by sliding the old view up while the new view comes from the bottom.
//        NSViewControllerTransitionSlideDown             =   0x20,   // Animates by sliding the old view down while the new view comes from the top.
//        NSViewControllerTransitionSlideLeft             =   0x40,   // Animates by sliding the old view to the left while the new view comes in from the right (both views move left).
//        NSViewControllerTransitionSlideRight            =   0x80,   // Animates by sliding the old view to the right while the new view comes in from the left (both views move right).
//        NSViewControllerTransitionSlideForward          =  0x140,   // Same as "Left", but automatically flips to be "Right" when NSApp.userInterfaceLayoutDirection is Right-to-Left.
//        NSViewControllerTransitionSlideBackward         =  0x180,   // Same as "Right", but automatically flips to be "Left" when NSApp.userInterfaceLayoutDirection is Right-to-Left.
//
//        NSViewControllerTransitionAllowUserInteraction  = 0x1000,   // Allow user interaction during the transaction; normally it is prevented for the parent view controller while the transition is happening.
//         */
        ////必须是父子视图
//        [self transitionFromViewController:self toViewController:thirdViewCtrl options:NSViewControllerTransitionCrossfade completionHandler:^{
//
//        }];
        
        
//        /*
//         NSPopoverBehaviorApplicationDefined = 0,
//        NSPopoverBehaviorTransient = 1,
//        NSPopoverBehaviorSemitransient = 2
//         */
//        [self presentViewController:thirdViewCtrl asPopoverRelativeToRect:self.view.frame ofView:self.view preferredEdge:NSRectEdgeMaxX behavior:NSPopoverBehaviorSemitransient];
        
        [self presentViewController:thirdViewCtrl animator:[PresentAnimator new]];
        
        return;
        if (_tableView.selectedRow < 0) {
            return;
        }
        FirstDataModel *subModel = [_dataSourceM objectAtIndex:[_tableView selectedRow]];
        if (subModel) {
            [_dataSourceM removeObject:subModel];
            [_tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:_tableView.selectedRow] withAnimation:NSTableViewAnimationSlideRight];
            [_showView removeAllDataSource];
        }
    }else if (button == _changeButton) {
        
//        TaskViewController *taskViewCtrl = [[TaskViewController alloc] init];
//        [self presentViewControllerAsSheet:taskViewCtrl];
        
        ExampleTabViewController *exampleViewCtrl = [[ExampleTabViewController alloc] init];
        [self presentViewControllerAsModalWindow:exampleViewCtrl];
        return;
        if (_tableView.selectedRow < 0) {
            return;
        }
         FirstDataModel *changeModel = [_dataSourceM objectAtIndex:[_tableView selectedRow]];
        if (changeModel) {
            [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
        }
    }
    
}
//选择图片后调用的方法
- (void)pictureTakerDidEnd:(IKPictureTaker *)picker returnCode:(NSInteger)code contextInfo:(void *)contextInfo {
    
    NSImage *img = [picker outputImage];
    
    if (img && code == NSModalResponseOK) {
         FirstDataModel *changeModel = [_dataSourceM objectAtIndex:[_tableView selectedRow]];
        changeModel.imageName = img;
        _showView.dataModel = changeModel;
        [_tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:[_tableView selectedRow]] columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
}
#pragma mark -NSTableViewDelegate,NSTabViewDelegate
//返回行数
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    return [_dataSourceM count];
}
//- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//
//  FirstDataModel *dataModel = [_dataSourceM objectAtIndex:row];
//    return dataModel;
//}
//每个单元内的view
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSString *identifier = tableColumn.identifier;
    FirstTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (!cellView) {
        cellView = [[FirstTableCellView alloc] init];
    }
    cellView.dataModel = [_dataSourceM objectAtIndex:row];
    return cellView;
}
//行高
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    
    return 44;
}
//是否可以选中单元格
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    
    return YES;
}
//选中的列
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn {
    
    NSLog(@"tableColumn ------- %@",tableColumn.title);
}
//选中的响应
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSTableView *tableView = notification.object;
    
    if(tableView == _tableView) {
        NSDictionary *dic = notification.userInfo;
        NSLog(@"dic -------- %@",dic);
        NSLog(@"selectRow ------- %ld,selectColumn ------- %ld",tableView.selectedRow,tableView.selectedColumn);
        if (_tableView.selectedRow >= 0 && _tableView.selectedRow < [_dataSourceM count]) {
            FirstDataModel *dataModel = [_dataSourceM objectAtIndex:tableView.selectedRow];
            
            _showView.dataModel = dataModel;
        }
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
