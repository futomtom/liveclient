//
//  RTMPServerViewController.swift
//  RTMP
//
//  Created by alexfu on 3/14/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit
import rtmpstream
import AVFoundation
import SnapKit

class RTMPServerViewController: UIViewController {
    
    @IBOutlet weak var ServerURL: UITextField!
    @IBOutlet weak var StreamingName: UITextField!
    @IBAction func StartLive(sender: AnyObject) {
        guard let url = ServerURL.text where !url.isEmpty ,let stream = StreamingName.text where !stream.isEmpty else {
            return
        }
        
        guard let text = ServerURL.text where !text.isEmpty else {
            return
        }
        
        if rtmpValidate(url) {
            if let vc = storyboard?.instantiateViewControllerWithIdentifier("livevc") as? liveViewController
            {
                vc.url=ServerURL.text
                vc.streamName=StreamingName.text
                
                self.navigationController?.pushViewController(vc, animated: true)  
            }
     
   
            
        }

    }
    
    
    func rtmpValidate(string: String?) -> Bool {
        let regEx = "((rtmp)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluateWithObject(string)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerURL.text="rtmp://192.168.0.103/live"
        StreamingName.text = "live"

        // Do any additional setup after loading the view.
    }
}
