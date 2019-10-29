//
//  FirstDataModel.h
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/9.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface FirstDataModel : NSObject

//名称
@property (nonatomic,copy) NSString     *nameTitle;

//图片名称
@property (nonatomic,strong) NSImage    *imageName;

@property (nonatomic,strong) NSColor    *imgColor;

@property (nonatomic,assign) NSInteger  score;

@end
