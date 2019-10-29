//
//  AppDelegate.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/8.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@property (nonatomic,assign) NSInteger  windowNumber;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self obtainWeekCount];
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, kScreenWidth / 2.0, kScreenHeight / 2.0) styleMask:style backing:NSBackingStoreBuffered defer:YES];
    
    //设置窗口的背景色
    self.window.opaque = NO;
    self.window.backgroundColor = [NSColor redColor];
    //设置Window的标题
    self.window.title = @"Hello world";
    
    //设置window的image
    self.window.miniwindowImage = [NSImage imageNamed:@"shockedface2_full"];
    
    [self.window makeKeyAndOrderFront:self];
    [self.window center];
//    _windowNumber = NSApp.mainWindow.windowNumber;
    
    //设置未读数
    NSApp.dockTile.badgeLabel = @"200";
//    //设置全屏模式
//    [self.window toggleFullScreen:self];
    
//    //点击window上的内容可拖动窗口
//    self.window.movableByWindowBackground = YES;
    
    //设置隐藏或者显示Dock 上的图标
    /*
    NSApplicationActivationPolicyRegular,
    NSApplicationActivationPolicyAccessory,
    NSApplicationActivationPolicyProhibited
     */
//    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
//    [NSApp unhideAllApplications:nil];
    
    ViewController *viewCtrl = [[ViewController alloc] init];
    
//    //10.10之前的
//    [self.window.contentView addSubview:viewCtrl.view];
    //10.10之后的
    self.window.contentViewController = viewCtrl;
    
    
    //创建模态窗口的方法
    //方法一 --------- Modal windows
//    [[NSApplication sharedApplication] runModalForWindow:self.window];
//    //结束Modal
//    [[NSApplication sharedApplication] stopModal];
    
    //方法二 ------ Modal sessions
    
//    //启动Modal sessions窗口
//    NSModalSession *sessionCode = [[NSApplication sharedApplication] beginModalSessionForWindow:self.window];
//    
//    //关闭
//    [[NSApplication sharedApplication] endModalSession:sessionCode];
    
    [self setupWindowIcon];
}
//设置window的image和title
- (void)setupWindowIcon {
    
    [self.window setRepresentedURL:[NSURL URLWithString:@"WindowTitle"]];
    self.window.title = @"FirstDemo";
    NSImage *img = [NSImage imageNamed:@"shockedface2_full"];
    /*
     NSWindowCloseButton,
     NSWindowMiniaturizeButton,
     NSWindowZoomButton,
     NSWindowToolbarButton,
     NSWindowDocumentIconButton,
     NSWindowDocumentVersionsButton NS_ENUM_AVAILABLE_MAC(10_7) = 6,
     NSWindowFullScreenButton NS_ENUM_DEPRECATED_MAC(10_7, 10_12, "The standard window button for NSWindowFullScreenButton is always nil; use NSWindowZoomButton instead"),
     */
    [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:img];
    
    NSLog(@"test ------------------ ");
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
//默认情况下，关闭了App的主窗口，再次点击Dock栏图标时，系统不会响应的。
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    
    if (flag) {
        return NO;
    }else{
        [_window makeKeyAndOrderFront:self];
        return YES;
    }
    
}
//给App在Dock上添加右键菜单选择
- (nullable NSMenu *)applicationDockMenu:(NSApplication *)sender {
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"提示"];
    
    NSMenuItem *copyItem = [[NSMenuItem alloc] initWithTitle:@"copy" action:@selector(menuItemClick:) keyEquivalent:@"copy"];
    [menu addItem:copyItem];
    
    NSMenuItem *deleteItem = [[NSMenuItem alloc] initWithTitle:@"delete" action:@selector(menuItemClick:) keyEquivalent:@"delete"];
    [menu addItem:deleteItem];
    
    return menu;
}
- (void)menuItemClick:(NSMenuItem *)item {
    
    if ([item.keyEquivalent isEqualToString:@"copy"]) {
        NSLog(@"copy click method");
    }else if ([item.keyEquivalent isEqualToString:@"delete"]){
        NSLog(@"delete click method");
    }
}

- (void)obtainWeekCount {
    
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:date];
    
    NSInteger weeak = [components year];
    
    NSLog(@"week ------- %ld",weeak);
}
@end
