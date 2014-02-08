//
//  HTPlayer.m
//  ParentHelper
//
//  Created by Mr.Yang on 13-9-16.
//  Copyright (c) 2013年 LT. All rights reserved.
//

#import "HTPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

static HTPlayer *htPlayer = nil;
@implementation HTPlayer

+ (HTPlayer *)sharedPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        htPlayer = [[HTPlayer alloc] init];
    });
    return htPlayer;
}

static void SoundFinished(SystemSoundID soundID,void* sample){
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID(sample);
    CFRelease(sample);
}

- (void)playMessageSound
{
    //receive message systemSound
    SystemSoundID soundID = 1012;
    AudioServicesPlaySystemSound(soundID);
}

- (void)playMessageComeSound
{
    //receive message systemSound
    static SystemSoundID soundID;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"chatcome" withExtension:@"wav"];
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);
        if (err) {
            NSLog(@"Error occurred assigning system sound!");
            return;
        }
    });

    AudioServicesPlaySystemSound(soundID);
}

- (void)playCustomerSound
{
    //receive message systemSound
    static SystemSoundID soundID;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"chatcome" withExtension:@"wav"];
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);
        if (err) {
            NSLog(@"Error occurred assigning system sound!");
            return;
        }
        /*添加音频结束时的回调*/
        //AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished,sample);
        
        //未添加回调
        AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, NULL,url);
    });
    
    /*开始播放*/
    AudioServicesPlaySystemSound(soundID);
}
@end
