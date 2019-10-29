//
//  PublicKnowledgePoint.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/15.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import "PublicKnowledgePoint.h"
#import <EventKit/EventKit.h>

@interface PublicKnowledgePoint()<NSSpeechSynthesizerDelegate>

@property (nonatomic,strong) EKEventStore *eventStore;

//提醒事件是否授权
@property (nonatomic,assign) BOOL         isAuthor;

@end

@implementation PublicKnowledgePoint

static PublicKnowledgePoint *manager = nil;
+ (PublicKnowledgePoint *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PublicKnowledgePoint alloc] init];
    });
    return manager;
}

//将数字转换为文字描述
- (NSString *)changeNumberToChina:(NSNumber *)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    /*
     NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle,
     NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,
     NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle,
     NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,
     NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,
     NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle,
     NSNumberFormatterOrdinalStyle API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) = kCFNumberFormatterOrdinalStyle,
     NSNumberFormatterCurrencyISOCodeStyle API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) = kCFNumberFormatterCurrencyISOCodeStyle,
     NSNumberFormatterCurrencyPluralStyle API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) = kCFNumberFormatterCurrencyPluralStyle,
     NSNumberFormatterCurrencyAccountingStyle API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) = kCFNumberFormatterCurrencyAccountingStyle,
     */
    //将数组转换为文字描述（与当前App设置的语言环境相关）
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    NSString *reStr = [formatter stringFromNumber:number];
    NSLog(@"reStr ------- %@",reStr);
    return reStr;
}
//将文字转换问语音
- (void)changeChinaToVoice:(NSString *)content {
    
//    content = @"Hello World";
    
    /*
     "com.apple.speech.synthesis.voice.Alex",
     "com.apple.speech.synthesis.voice.alice",
     "com.apple.speech.synthesis.voice.alva",
     "com.apple.speech.synthesis.voice.amelie",
     "com.apple.speech.synthesis.voice.anna",
     "com.apple.speech.synthesis.voice.carmit",
     "com.apple.speech.synthesis.voice.damayanti",
     "com.apple.speech.synthesis.voice.daniel",
     "com.apple.speech.synthesis.voice.diego",
     "com.apple.speech.synthesis.voice.ellen",
     "com.apple.speech.synthesis.voice.fiona",
     "com.apple.speech.synthesis.voice.Fred",
     "com.apple.speech.synthesis.voice.ioana",
     "com.apple.speech.synthesis.voice.joana",
     "com.apple.speech.synthesis.voice.jorge",
     "com.apple.speech.synthesis.voice.juan",
     "com.apple.speech.synthesis.voice.kanya",
     "com.apple.speech.synthesis.voice.karen",
     "com.apple.speech.synthesis.voice.kyoko",
     "com.apple.speech.synthesis.voice.laura",
     "com.apple.speech.synthesis.voice.lekha",
     "com.apple.speech.synthesis.voice.luca",
     "com.apple.speech.synthesis.voice.luciana",
     "com.apple.speech.synthesis.voice.maged",
     "com.apple.speech.synthesis.voice.mariska",
     "com.apple.speech.synthesis.voice.mei-jia",
     "com.apple.speech.synthesis.voice.melina",
     "com.apple.speech.synthesis.voice.milena",
     "com.apple.speech.synthesis.voice.moira",
     "com.apple.speech.synthesis.voice.monica",
     "com.apple.speech.synthesis.voice.nora",
     "com.apple.speech.synthesis.voice.paulina",
     "com.apple.speech.synthesis.voice.samantha",
     "com.apple.speech.synthesis.voice.sara",
     "com.apple.speech.synthesis.voice.satu",
     "com.apple.speech.synthesis.voice.sin-ji",
     "com.apple.speech.synthesis.voice.tessa",
     "com.apple.speech.synthesis.voice.thomas",
     "com.apple.speech.synthesis.voice.ting-ting",
     "com.apple.speech.synthesis.voice.veena",
     "com.apple.speech.synthesis.voice.Victoria",
     "com.apple.speech.synthesis.voice.xander",
     "com.apple.speech.synthesis.voice.yelda",
     "com.apple.speech.synthesis.voice.yuna",
     "com.apple.speech.synthesis.voice.yuri",
     "com.apple.speech.synthesis.voice.zosia",
     "com.apple.speech.synthesis.voice.zuzana"
     */
    NSSpeechSynthesizer *speech = [[NSSpeechSynthesizer alloc] initWithVoice:@"com.apple.speech.synthesis.voice.Alex"];
//    NSArray *array = NSSpeechSynthesizer.availableVoices;
//    NSLog(@"array ------ %@",array);
    speech.delegate = self;
    [speech startSpeakingString:content];
    
}
#pragma mark -NSSpeechSynthesizerDelegate
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking {
    
    NSLog(@"finish speak");
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)characterRange ofString:(NSString *)string {
  NSLog(@"will Speak Word ------- %@",string);
    
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakPhoneme:(short)phonemeOpcode {
    NSLog(@"will Speak Phoneme -------- %c",phonemeOpcode);
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didEncounterErrorAtIndex:(NSUInteger)characterIndex ofString:(NSString *)string message:(NSString *)message {
    
    NSLog(@"string ------- %@,message ------ %@",string,message);
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didEncounterSyncMessage:(NSString *)message {
    NSLog(@"finish speak");
}

//添加系统提醒事件
- (void)addSystemRemindEvent {
    
    _eventStore = [[EKEventStore alloc] init];
    //检测是否进行授权
    [self remindMe];
}
- (void)remindMe {
    
    //获取系统的授权状态
    /*
     EKAuthorizationStatusNotDetermined = 0,
     EKAuthorizationStatusRestricted,
     EKAuthorizationStatusDenied,
     EKAuthorizationStatusAuthorized,
     */
   EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (status) {
        case EKAuthorizationStatusAuthorized:
            //已授权
            _isAuthor = YES;
            break;
        case EKAuthorizationStatusNotDetermined:
            //尚未进行授权
        {
            NSLog(@"尚未进行授权");
            __weak typeof(self) weakSelf = self;
            [_eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        strongSelf.isAuthor = granted;
                        [strongSelf createRemind];
                    });
                }
            }];
        }
            break;
        case EKAuthorizationStatusDenied:
            //用户拒绝授权
            NSLog(@"用户拒绝授权");
            break;
        case EKAuthorizationStatusRestricted:
            //用户拒绝授权
            NSLog(@"用户拒绝授权");
            break;
            
        default:
            break;
    }
}
//创建提醒事件
- (void)createRemind {
    
   EKReminder *reminder = [EKReminder reminderWithEventStore:_eventStore];
    //设置新提醒
    reminder.calendar = [_eventStore defaultCalendarForNewReminders];
    //设置提醒事件的标题
    reminder.title = @"reminde title";
    //设置提醒
    NSDate *currentDate = [NSDate dateWithTimeInterval:15 sinceDate:[NSDate date]];
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:currentDate];
    
    //
    [reminder addAlarm:alarm];
    NSError *error = nil;
    [_eventStore saveReminder:reminder commit:YES error:&error];
    
    if (error) {
        NSLog(@"error ------- %@",error);
    }
}
@end
