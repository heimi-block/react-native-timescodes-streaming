//
//  LFLiveKitViewManager.m
//  Hoowoo
//
//  Created by 骆鹏霄 on 2020/6/16.
//  Copyright © 2020 TimesCodes. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "React/RCTViewManager.h"
@interface RCT_EXTERN_MODULE(LFLiveKitViewManager, RCTViewManager)

// 推流RTMP URL地址
RCT_EXPORT_VIEW_PROPERTY(streamURL, NSString)
// 摄像头前置or后置
RCT_EXPORT_VIEW_PROPERTY(cameraFronted, BOOL)
// 美颜滤镜开启or关闭
RCT_EXPORT_VIEW_PROPERTY(beautyFace, BOOL)
// 开始直播or停止直播
RCT_EXPORT_VIEW_PROPERTY(started, BOOL)

// streaming ready to start
RCT_EXPORT_VIEW_PROPERTY(onReady, RCTDirectEventBlock)
// streaming ready
RCT_EXPORT_VIEW_PROPERTY(onPending, RCTDirectEventBlock)
// streaming start
RCT_EXPORT_VIEW_PROPERTY(onStart, RCTDirectEventBlock)
// straming error
RCT_EXPORT_VIEW_PROPERTY(onError, RCTDirectEventBlock)
// streaming stop
RCT_EXPORT_VIEW_PROPERTY(onStop, RCTDirectEventBlock)

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
