//
//  RTMPServerViewController.swift
//  RTMP
//
//  Created by alexfu on 3/14/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit
import rtmpStreaming
import AVFoundation
import SnapKit

class liveViewController: UIViewController {

    var rtmpConnection:RTMPConnection = RTMPConnection()
    var rtmpStream:RTMPStream!
    var sharedObject:RTMPSharedObject!
    var url:String!
    var streamName:String!
    var currentPosition:AVCaptureDevicePosition = AVCaptureDevicePosition.Back

    
  //  @IBOutlet weak var touchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        rtmpStream = RTMPStream(rtmpConnection: rtmpConnection)
        rtmpStream.syncOrientation = true
        rtmpStream.attachAudio(AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio))
        rtmpStream.attachCamera(AVCaptureSessionManager.deviceWithPosition(.Back))
       
        rtmpStream.audioSettings["bitrate"] = 32
        rtmpStream.videoSettings["bitrate"] = 4000
        
        print(rtmpStream.videoGravity)
        
        rtmpStream.captureSettings = [
            "continuousAutofocus": true,
            "continuousExposure": true,
        ]
        rtmpConnection.addEventListener(Event.RTMP_STATUS, selector:"streamingStatusHandler:", observer: self)
        rtmpConnection.connect(url)
        
        
        // Do any additional setup after loading the view.
    }
    
    func streamingStatusHandler(notification:NSNotification) {
        let e:Event = Event.from(notification)
        if let data:ASObject = e.data as? ASObject , code:String = data["code"] as? String {
            switch code {
            case RTMPConnection.Code.ConnectSuccess.rawValue:
                rtmpStream!.publish(streamName)
            default:
                break
            }
        }
    }


    override func viewWillAppear(animated: Bool) {
        view.addSubview(rtmpStream.view)
/*
        weak var weakself = self
        rtmpStream.view.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(weakself!.view)
        }
*/
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        rtmpStream.view.frame = view.frame
      
    }



}
