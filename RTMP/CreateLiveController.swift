//
//  CreateLiveController.swift
//  RTMP
//
//  Created by alexfu on 3/14/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit

class CreateLiveController: UIViewController {



    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
   func CreateNewLive(sender: AnyObject) {
        
        UsingOauth2(googleOauth2Settings, performWithToken: { token in
            YoutubeService.OAuthToken = token
            YoutubeService.CreateNew({ (success, result) -> Void in
                
                if(success){
                    print("getdata")
                    self.items=result!
                    self.tableView.reloadData()
                }
                else
                {
                    print("get data fail")
                }
                
                
            })
            }, errorHandler: {
                print("Oauth2 failed")
        })
    }
*/

}
