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
import SCLAlertView




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
                    if self.items.count == 0
                    {
                        let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("No Pre created Youtube broadcast", subTitle: "create live will implement later.")

                    }
                    self.tableView.reloadData()
                    self.prefetchStreamName()
                    }
            })},errorHandler:{     })
    }
    
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
        func prefetchStreamName()
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                for i in 0 ..< self.items.count {
                    YoutubeService.getStreamName(self.items[i], completion: { (result) -> Void in
                        self.items[i].ingestionAddress=result![0]
                        self.items[i].streamName=result![1]
                    })}})
        }
  
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "youtube"){

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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            
            let liveVC = storyboard?.instantiateViewControllerWithIdentifier("livevc") as! liveViewController
            let selected=(tableView.indexPathForSelectedRow?.row)!
            
            if items[selected].streamName.length == 0 {
                YoutubeService.getStreamName(items[selected],completion: { (result) -> Void in
                    self.items[selected].ingestionAddress=result![0]
                    self.items[selected].streamName=result![1]
                    
                    liveVC.url = self.items[selected].ingestionAddress
                    liveVC.streamName = self.items[selected].streamName
                    self.navigationController?.pushViewController(liveVC, animated: true)
                })
            }else
            {
                liveVC.url = items[selected].ingestionAddress
                liveVC.streamName = items[selected].streamName
                 self.navigationController?.pushViewController(liveVC, animated: true)
            }
  
    }
    

}


