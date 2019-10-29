//
//  main.m
//  FirstDemo
//
//  Created by it-0003005 on 2019/5/8.
//  Copyright © 2019年 it-0003005. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    
    NSApplication *app = [NSApplication sharedApplication];
    
    AppDelegate *delegate = [[AppDelegate alloc] init];
    
    app.delegate = delegate;
    
    app.mainMenu = [[NSMenu alloc] initWithTitle:@"title"];
    
    return NSApplicationMain(argc, argv);
}
