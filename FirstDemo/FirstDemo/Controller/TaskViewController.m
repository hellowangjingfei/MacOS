//
//  TaskViewController.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/14.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "TaskViewController.h"


@interface TaskViewController ()

//名称
@property (nonatomic,strong) NSTextField  *firstNameTextField;

//输入框
@property (nonatomic,strong) NSTextField  *urlTextField;

//路径
@property (nonatomic,strong) NSTextField  *secondNameTextField;

//保存路径
@property (nonatomic,strong) NSTextField  *pathTextField;

//选择路径按钮
@property (nonatomic,strong) NSButton     *selectButton;

//下载按钮
@property (nonatomic,strong) NSButton     *pullButton;

//内容
@property (nonatomic,strong) NSTextView   *contentTextView;

//记录选择的路径
@property (nonatomic,copy) NSString       *filePath;

//是否正在下载中
@property (nonatomic,assign) BOOL         isLoading;

@property (nonatomic,strong) NSPipe       *outputPipe;

@property (nonatomic,strong) NSTask       *task;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self createSubviewsUI];
}
#pragma mark -Create UI
- (void)createSubviewsUI {
    
    //名称
    _firstNameTextField = [self createTextField];
    _firstNameTextField.stringValue = @"Git Repo Url:";
    [self.view addSubview:_firstNameTextField];
    
    //输入框
    _urlTextField = [self createTextField];
    _urlTextField.bordered = YES;
    _urlTextField.editable = YES;
    _urlTextField.backgroundColor = [NSColor whiteColor];
    [self.view addSubview:_urlTextField];
    
    //路径
    _secondNameTextField = [self createTextField];
    _secondNameTextField.stringValue = @"Save path:";
    [self.view addSubview:_secondNameTextField];
    
    //保存路径
    _pathTextField = [self createTextField];
    _pathTextField.placeholderString = @"select directory for save repo";
    [self.view addSubview:_pathTextField];
    
    //选择路径按钮
    _selectButton = [self createButton];
    /*
     NSButtonTypeMomentaryLight    = 0,
     NSButtonTypePushOnPushOff     = 1,
     NSButtonTypeToggle            = 2,
     NSButtonTypeSwitch            = 3,
     NSButtonTypeRadio             = 4,
     NSButtonTypeMomentaryChange   = 5,
     NSButtonTypeOnOff             = 6,
     NSButtonTypeMomentaryPushIn   = 7,
     NSButtonTypeAccelerator NS_ENUM_AVAILABLE_MAC(10_10_3) = 8,
     NSButtonTypeMultiLevelAccelerator NS_ENUM_AVAILABLE_MAC(10_10_3) = 9,
     */
    [_selectButton setButtonType:NSButtonTypeMomentaryLight];
    /*
     NSBezelStyleRounded           = 1,
     NSBezelStyleRegularSquare     = 2,
     NSBezelStyleDisclosure        = 5,
     NSBezelStyleShadowlessSquare  = 6,
     NSBezelStyleCircular          = 7,
     NSBezelStyleTexturedSquare    = 8,
     NSBezelStyleHelpButton        = 9,
     NSBezelStyleSmallSquare       = 10,
     NSBezelStyleTexturedRounded   = 11,
     NSBezelStyleRoundRect         = 12,
     NSBezelStyleRecessed          = 13,
     NSBezelStyleRoundedDisclosure = 14,
     NSBezelStyleInline NS_ENUM_AVAILABLE_MAC(10_7) = 15,
     */
    _selectButton.bezelStyle = NSBezelStyleRegularSquare;
    _selectButton.title = @"^";
    [self.view addSubview:_selectButton];
    
    //下载按钮
    _pullButton = [self createButton];
    [_pullButton setButtonType:NSButtonTypeMomentaryLight];
    _pullButton.title = @"Git pull";
    [self.view addSubview:_pullButton];
    
    //内容
    _contentTextView = [[NSTextView alloc] init];
    _contentTextView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:_contentTextView];
    
    [self makeUIConstraints];
}
- (NSTextField *)createTextField {
    
    NSTextField *textField = [[NSTextField alloc] init];
    textField.editable = NO;
    textField.bordered = NO;
    textField.backgroundColor = [NSColor clearColor];
    return textField;
}
- (NSButton *)createButton {
    
    NSButton *button = [NSButton buttonWithTitle:@"" target:self action:@selector(buttonClick:)];
    return button;
}
#pragma mark -Constraints
- (void)makeUIConstraints {
    
    //名称
    [_firstNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(40);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    //输入框
    [_urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-40);
        make.top.mas_equalTo(self.firstNameTextField.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.firstNameTextField.mas_right).mas_offset(5);
        make.height.mas_equalTo(20);
    }];
    
    //路径
    [_secondNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(40);
        make.top.mas_equalTo(self.firstNameTextField.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    //保存路径
    [_pathTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-70);
        make.top.mas_equalTo(self.secondNameTextField.mas_top).mas_offset(0);
        make.left.mas_equalTo(self.secondNameTextField.mas_right).mas_offset(5);
        make.height.mas_equalTo(20);
    }];
    
    //选择路径按钮
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.urlTextField.mas_right).mas_offset(0);
        make.centerY.mas_equalTo(self.pathTextField.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //下载按钮
    [_pullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.pathTextField.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    //内容
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstNameTextField.mas_left);
        make.top.mas_equalTo(self.pullButton.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(self.urlTextField.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-20);
    }];
    
}
#pragma mark -Click Method
- (void)buttonClick:(NSButton *)button {
    
    if (button == _selectButton) {
        //选择文件放置的路径
        [self selectDownLoadPath];
    }else if (button == _pullButton) {
        //点击下载
        NSString *usrStr = _urlTextField.stringValue;
        if ([usrStr length] == 0 || usrStr == nil) {
            [self markedWords:@"请填写下载路径"];
            return;
        }
        [self downLoadGithubFile];
    }
}

//选择下载的路径
- (void)selectDownLoadPath {
    
    //1.创建打开文档面板对象
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    //2.设置确认按钮文字
    openPanel.prompt = @"select";
    //3.设置禁止选择文件
    openPanel.canChooseFiles = YES;
    //设置可以选择的目录
    openPanel.canChooseDirectories = YES;
    
    if ([openPanel runModal] == NSModalResponseOK) {
        //7.获取选择的路径
        NSString *pathStr = openPanel.directoryURL.path;
        self.pathTextField.stringValue = pathStr;
        //8.保存用户选择的路径（为了获取访问权限）
        _filePath = pathStr;
    }
}
//下载github上的文件
- (void)downLoadGithubFile {
    
    if ([_filePath length] == 0 || _filePath == nil) {
        [self markedWords:@"请选择存储路径"];
        return;
    }
    //判断是否正在执行
    if (_isLoading) {
        [self markedWords:@"正在下载中。。。"];
        return;
    }
    _isLoading = YES;
    
    //创建NSTask
    _task = [self createTask];
    
    //设置task
    
    //设置执行的绝对路径
    _task.arguments = @[@"-c",@"cd \(executePath); git clone \(repoPath.stringValue)"];
    
    //执行结束的闭包
    __weak typeof(self) weakSelf = self;
    [_task setTerminationHandler:^(NSTask * _Nonnull tk) {
        //恢复执行标记
        weakSelf.isLoading = NO;
        //显示clone的仓库文件列表
        [weakSelf showFilesList];
    }];
    
    [self captureStandardOutputAndRouteToTextView:_task];
    //开启执行
    [_task launch];
    
    //阻塞直到执行完毕
    [_task waitUntilExit];
    
}
//如果路径为空
- (void)markedWords:(NSString *)message {
    
    NSAlert *alert = [[NSAlert alloc] init];
    
    //    [alert addButtonWithTitle:@"提示"];
    
    //添加ok按钮
    [alert addButtonWithTitle:@"OK"];
    
    //弹窗内容
    alert.messageText = @"提示";
    
    //描述性文字
    alert.informativeText = message;
    
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"This is OK button tap");
        }
    }];
}
//显示clone的仓库文件列表
- (void)showFilesList {
    
    if ([_filePath length] == 0 || _filePath == nil) {
        [self markedWords:@"请选择存储路径"];
        return;
    }
    NSTask *listTask = [self createTask];
    
    //设置task

    //设置执行的绝对路径
    listTask.arguments = @[@"-c",@"cd \(executePath/(repoPath.stringValue as NSString).lastPathComponent); ls "];
  
    [self captureStandardOutputAndRouteToTextView:listTask];
    
    [listTask launch];
    
    //阻塞直到执行完毕
    [listTask waitUntilExit];
    
}

- (void)captureStandardOutputAndRouteToTextView:(NSTask *)task {
    
    //1.设置标准输出管道
    _outputPipe = [NSPipe pipe];
    task.standardOutput = _outputPipe;
    
    //2.在后台线程等待数据和通知
    [_outputPipe.fileHandleForReading waitForDataInBackgroundAndNotify];
    
    //3.接收通知消息
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NSFileHandleDataAvailableNotification object:_outputPipe.fileHandleForReading];
}
//接收通知
- (void)receiveNotification:(NSNotification *)noti {
    
    //4.获取管道数据 转为字符串
    NSData *outputData = _outputPipe.fileHandleForReading.availableData;
    
    NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];


    if ([outputString length] != 0 && outputString != nil) {
        
        //5.在主线程中处理UI
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSString *previousOutputStr = self.contentTextView.string;
            
            NSString *nextOutputStr = [NSString stringWithFormat:@"%@\n%@",previousOutputStr,outputString];
            
            self.contentTextView.string = nextOutputStr;
            
            //滚动到可视位置
            NSRange range = NSMakeRange(0,nextOutputStr.length);
            
            [self.contentTextView scrollRangeToVisible:range];
            
        });
    }
    
    //6.继续等待新数据和通知
    [self.outputPipe.fileHandleForReading waitForDataInBackgroundAndNotify];
}
- (NSTask *)createTask {
    
    NSTask *listTask = [[NSTask alloc] init];
    //设置task
    listTask.launchPath = @"/bin/bash";
    return listTask;
}
@end
