//
//  ThirdViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/13.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "ThirdViewController.h"
#import "Masonry.h"
#import "OutLineCellRowView.h"
#import "OutLineDataModel.h"

@interface ThirdViewController ()<NSOutlineViewDelegate,NSOutlineViewDataSource>

@property (nonatomic,strong) NSScrollView      *scrollView;

@property (nonatomic,strong) NSOutlineView     *outLineView;

@property (nonatomic,strong) OutLineDataModel  *rootDataModel;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self requestDataSource];
    
    [self createSubviewsUI];
    
}
- (void)loadView {
    
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor purpleColor].CGColor;
    
}
#pragma mark -DataSource
- (void)requestDataSource {
    
    _rootDataModel = [[OutLineDataModel alloc] init];
    _rootDataModel.nodeName = @"root";
    
    OutLineDataModel *firstDataModel = [[OutLineDataModel alloc] init];
    firstDataModel.nodeName = @"节点-1";
    
    OutLineDataModel *firstNode1Model = [[OutLineDataModel alloc] init];
    firstNode1Model.nodeName = @"节点-1-1";
    
    OutLineDataModel *firstNode2Model = [[OutLineDataModel alloc] init];
    firstNode2Model.nodeName = @"节点-1-2";
    
    firstDataModel.nodeArrayM = @[firstNode1Model,firstNode2Model];
    
    OutLineDataModel *secondDataModel = [[OutLineDataModel alloc] init];
    secondDataModel.nodeName = @"节点-2";
    
    OutLineDataModel *secondNode1Model = [[OutLineDataModel alloc] init];
    secondNode1Model.nodeName = @"节点-2-1";
    
    OutLineDataModel *secondNode2Model = [[OutLineDataModel alloc] init];
    secondNode2Model.nodeName = @"节点-2-2";
    
     secondDataModel.nodeArrayM = @[secondNode1Model,secondNode2Model];
    

    _rootDataModel.nodeArrayM = @[firstDataModel,secondDataModel];
    
    [_outLineView reloadData];
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    _scrollView = [[NSScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] init];
    tableColumn.resizingMask = NSTableColumnAutoresizingMask;
    
    _outLineView = [[NSOutlineView alloc] init];
    _outLineView.allowsColumnResizing = YES;
    _outLineView.delegate = self;
    _outLineView.dataSource = self;
    _outLineView.headerView = nil;
    _outLineView.columnAutoresizingStyle = NSTableViewFirstColumnOnlyAutoresizingStyle;
    //背景颜色的交替，一行白色，一行灰色
//    _outLineView.usesAlternatingRowBackgroundColors = YES;
    [_outLineView addTableColumn:tableColumn];
    _scrollView.documentView = _outLineView;
    
    [self makeUIConstraints];
}

#pragma mark -Constraints
- (void)makeUIConstraints {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).mas_offset(NSEdgeInsetsMake(10, 10, 10, 10));
    }];
}

#pragma mark -NSOutlineViewDelegate,NSOutlineViewDataSource
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    
    //当item为空时表示根节点
    if (item != nil  && [item isKindOfClass:[OutLineDataModel class]]) {
        return [(OutLineDataModel *)item nodeArrayM].count;
    }
    return _rootDataModel.nodeArrayM.count;
}
//每一层级节点的模型对象为item时，根据item获取子节点模型。item为空时表示获取顶级节点模型
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    
    if (!item) {
        return [_rootDataModel.nodeArrayM objectAtIndex:index];
    }else{
        OutLineDataModel *model = (OutLineDataModel *)item;
        return [model.nodeArrayM objectAtIndex:index];
    }
}
//节点是否可以打开/关闭
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    
    //count > 0 表示子节点，需要允许Expandable
    if (!item) {
        return _rootDataModel.nodeArrayM.count > 0;
    }else{
        OutLineDataModel *model = (OutLineDataModel *)item;
        return model.nodeArrayM.count > 0;
    }
}
//设置每个数据载体对应的具体数据，根据节点模型对象item，更新节点视图
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    
    return item;
}
- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item {
    
    return 50;
}
//是否绘制组行样式
- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {

    if (item && [item isKindOfClass:[OutLineDataModel class]] && [(OutLineDataModel *)item nodeArrayM]) {
        return YES;
    }
    return NO;
}
- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    OutLineCellRowView *cell = [outlineView makeViewWithIdentifier:@"OutLineCellRowView" owner:self];
    
    if (cell == nil) {
        cell = [[OutLineCellRowView alloc] init];
        cell.identifier = @"OutLineCellRowView";
    }
    return cell;
}
- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    
    NSOutlineView *outLineView = (NSOutlineView *)notification.object;
    
    NSInteger index = [outLineView selectedRow];
    OutLineDataModel *dataModel = (OutLineDataModel *)[outLineView itemAtRow:index];
    
    NSLog(@"nodeName ------- %@",dataModel.nodeName);
}
- (void)outlineViewItemDidExpand:(NSNotification *)notification {
    
    NSDictionary *dic = notification.userInfo;
    
    OutLineDataModel *dataModel = (OutLineDataModel *)[dic objectForKey:@"NSObject"];
    
    
    NSLog(@"nodeName ------- %@",dataModel.nodeName);
    
//    [self.presentingViewController dismissViewController:self];
}
@end
