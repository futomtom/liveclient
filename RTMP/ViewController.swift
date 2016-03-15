//
//  ViewController.swift
//  RTMP
//
//  Created by alexfu on 3/14/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireOauth2
import SnapKit




class ViewController: UIViewController {
    var items:[Item]=[]
    
    @IBOutlet weak var ServerButton: CustomBorderButton!
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var ChooseExistButton: CustomBorderButton!
    
    @IBOutlet weak var CreateNewButton: CustomBorderButton!
    let googleOauth2Settings = Oauth2Settings(
        baseURL: "https://www.googleapis.com/youtube/v3",
        authorizeURL: "https://accounts.google.com/o/oauth2/auth",
        tokenURL: "https://accounts.google.com/o/oauth2/token",
        redirectURL: "http://localhost",
        clientID: "372242456957-vt51npqa6auhlh68paov5fie52s4iujm.apps.googleusercontent.com",
        clientSecret: "_NNs7RUhNBIP6n_cEDDVOWNI",
        scope: "https://www.googleapis.com/auth/youtube"
    )

    
    @IBOutlet weak var result: UITextView!
    
    @IBAction func ListBroadcast(sender: AnyObject) {
      
        UsingOauth2(googleOauth2Settings, performWithToken: { token in
            YoutubeService.OAuthToken = token
            YoutubeService.List({ (success, result) -> Void in
                
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
    
    
          
        
        
        
        
        
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "playVC") {
//            let playVC:PlayViewController = segue.destinationViewController as! PlayViewController
//            playVC.playItem=items[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listcell", forIndexPath: indexPath) as! ListViewCell
    
        cell.renderData(items[indexPath.row])
        return cell
    }
    
    
    
 


}


