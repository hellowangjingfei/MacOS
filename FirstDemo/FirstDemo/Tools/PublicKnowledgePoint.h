//
//  PublicKnowledgePoint.h
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/15.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicKnowledgePoint : NSObject

+ (PublicKnowledgePoint *)sharedInstance;

//将数字转换为文字描述
- (NSString *)changeNumberToChina:(NSNumber *)number;

//将文字转换为语音
- (void)changeChinaToVoice:(NSString *)content;

//添加系统提醒事件
- (void)addSystemRemindEvent;

@end
