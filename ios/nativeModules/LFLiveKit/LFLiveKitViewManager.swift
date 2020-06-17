//
//  LFLiveKitViewManager.swift
//  Hoowoo
//
//  Created by 骆鹏霄 on 2020/6/16.
//  Copyright © 2020 TimesCodes. All rights reserved.
//

import Foundation

@objc(LFLiveKitViewManager)
class LFLiveKitViewManager: RCTViewManager {
  // 主播视频采集线程VIEW
  override func view() -> UIView! {
    let rootViewController: UIViewController? = RCTPresentedViewController()
    let _LFLiveKitView = LFLiveKitView(frame: (rootViewController!.view.bounds))
    return _LFLiveKitView
  }
}
