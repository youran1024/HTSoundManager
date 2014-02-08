//
//  HTPlayer.h
//  ParentHelper
//
//  Created by Mr.Yang on 13-9-16.
//  Copyright (c) 2013年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTPlayer : NSObject

+ (HTPlayer *)sharedPlayer;

- (void)playMessageSound;
- (void)playMessageComeSound;
- (void)playCustomerSound;

@end
