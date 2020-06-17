//
//  LFLiveKitView.swift
//  Hoowoo
//
//  Created by 骆鹏霄 on 2020/6/16.
//  Copyright © 2020 TimesCodes. All rights reserved.
//

import UIKit

class LFLiveKitView: UIView, LFLiveSessionDelegate {
    
    @objc var onReady: RCTDirectEventBlock?
    @objc var onPending: RCTDirectEventBlock?
    @objc var onStart: RCTDirectEventBlock?
    @objc var onError: RCTDirectEventBlock?
    @objc var onStop: RCTDirectEventBlock?
    
    @objc var streamURL: NSString = "rtmp://" {
        didSet {
            print("接收到了传入的推流地址URL: \(streamURL)")
        }
    }
    
    @objc var cameraFronted: Bool = true {
        didSet {
            print("接收到了传入的摄像头是否前置: \(cameraFronted)")
            session.captureDevicePosition = cameraFronted ? AVCaptureDevice.Position.front :AVCaptureDevice.Position.back
        }
    }
    
    @objc var beautyFace: Bool = true {
        didSet {
            print("接收到了传入的是否开启美颜: \(beautyFace)")
            session.beautyFace = beautyFace
            session.beautyLevel = 1.0  // 美颜等级 默认0.5 最高1.0
        }
    }
    
    @objc var started: Bool = true {
        didSet {
            print("接收到了传入的是否开始直播: \(started)")
            if(started) {
                let stream = LFLiveStreamInfo()
                stream.url = streamURL as String
                session.startLive(stream)
            } else {
                session.stopLive()
            }
        }
    }
    
    //MARK: - INIT
    
    // 初始化直播采集View
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func _setupUI() {
       self.requestAccessForVideo()
       self.requestAccessForAudio()
       session.delegate = self
       session.preView = self
       self.backgroundColor = UIColor.clear
       self.addSubview(containerView)
    }
    

    //MARK: - Callbacks
    
    // 回调
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("debugInfo: \(debugInfo?.currentBandwidth)")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("errorCode: \(errorCode.rawValue)")
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("liveStateDidChange: \(state.rawValue)")
        switch state {
        case LFLiveState.ready:
            if onReady != nil {
                onReady!(["state": "ready", "text": "未连接"])
            }
            break;
        case LFLiveState.pending:
            if onPending != nil {
                onPending!(["state": "pending", "text": "连接中"])
            }
            break;
        case LFLiveState.start:
            if onStart != nil {
                onStart!(["state": "start", "text": "已连接"])
            }
            break;
        case LFLiveState.error:
            if onError != nil {
                onError!(["state": "error", "text": "连接错误"])
            }
            break;
        case LFLiveState.stop:
            if onStop != nil {
                onStop!(["state": "stop", "text": "未连接"])
            }
            break;
        default:
                break;
        }
    }
    


    //  默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏
    var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.low)
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.high3)
        videoConfiguration!.outputImageOrientation = UIApplication.shared.statusBarOrientation
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        return session!
    }()

    // 视图
    var containerView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        containerView.backgroundColor = UIColor.clear
        containerView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleHeight]
        return containerView
    }()
    
    //MARK: AccessAuth
    func requestAccessForVideo() -> Void {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video);
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if(granted){
                    DispatchQueue.main.async {
                        self.session.running = true
                    }
                }
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.authorized:
            session.running = true;
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
    func requestAccessForAudio() -> Void {
        let status = AVCaptureDevice.authorizationStatus(for:AVMediaType.audio)
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (granted) in
                
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.authorized:
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
}
