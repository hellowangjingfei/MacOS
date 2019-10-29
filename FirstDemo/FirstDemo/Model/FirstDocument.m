//
//  FirstDocument.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/13.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "FirstDocument.h"
#import "DocumentWindowController.h"

@interface FirstDocument()

@property (nonatomic,strong) NSData  *saveData;

@end

@implementation FirstDocument

/*
- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return <#nibName#>;
}
*/

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}
//将当前文档保存时调用
- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
        return nil;
    }
    NSLog(@"保存文件");
    return _saveData;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
    }
    _saveData = data;
    NSLog(@"读取内容 来自\(self.fileURL)");
    return NO;
}
//是否自动保存（除用户选择外的所有保存方式 都是非自动保存，像按钮..点击的方法可以保存，其他的不能）
+ (BOOL)autosavesInPlace {
    
    return YES;
}
//用于为Document绑定WindowController，当打开新的Document时，对应的WindowController就会被打开
- (void)makeWindowControllers {
    DocumentWindowController *documentWindowCtrl = [[DocumentWindowController alloc] init];
    [self addWindowController:documentWindowCtrl];
}
- (void)autosaveWithImplicitCancellability:(BOOL)autosavingIsImplicitlyCancellable completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    
    NSLog(@"调用自动保存");
    completionHandler([[NSError alloc] initWithDomain:@"错误提示" code:0 userInfo:nil]);
}
@end
