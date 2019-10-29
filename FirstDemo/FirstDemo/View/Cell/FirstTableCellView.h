//
//  FirstTableCellView.h
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/9.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FirstDataModel.h"

@interface FirstTableCellView : NSTableCellView

@property (nonatomic,strong) FirstDataModel  *dataModel;

@end
