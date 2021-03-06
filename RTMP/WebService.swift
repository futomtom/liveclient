//
//  WebService.swift
//  CodeTest2
//
//  Created by alexfu on 3/12/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON




class YoutubeService {
    
    static var OAuthToken: String?
    // Add URL parameters
    
    static var header = ["Authorization":""]
    
    static let base="https://www.googleapis.com/youtube/v3/"
    
  
    static func List(completion: (success: Bool, result: [Item]?) -> Void)
    {
        var items : [Item] = []
        let url=base+"liveBroadcasts"
        
        if let token = OAuthToken {
            header["Authorization"] = "Bearer " + token
            
        }
        
        let Params = [
            "part":"id, snippet,contentDetails",
            "mine":"true"
        ]

        Alamofire.request(.GET,url, parameters: Params,headers:  header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in

                if let result = response.result.value {
                    let json=JSON(result)
                     for (_, object) in json["items"]
                    {
                        let item = Item(itemData: object)
                        if let _ = item.boundStreamId
                        {
                            items.append(item)
                        }
                    }

                completion(success: true, result: items)
                }
                else{
                completion(success: false, result: nil)
                }
        }
    }
    
    static func getStreamName(item:Item,completion: [String]? -> Void) {
        let url=base+"liveStreams"
        if let token = OAuthToken {
            header["Authorization"] = "Bearer " + token
            
        }
        
        let Params = [
            "part":"id, cdn",
            "id":item.boundStreamId
        ]
        

        Alamofire.request(.GET,url, parameters: Params,headers:  header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                if let result = response.result.value {
                    let json=JSON(result)
                    let info=json["items"][0]["cdn"]["ingestionInfo"]
                    let streamName = info["streamName"].string!
                    let ingestionAddress=info["ingestionAddress"].string!
                    completion([ingestionAddress,streamName])
                }else {
                 completion([])
                }
            }
    }
    
    
    static func CreateNew(completion: (success: Bool, result: [Item]?) -> Void)
    {
        var items : [Item] = []
        let url=base+"liveStreams"
        
        if let token = OAuthToken {
            header["Authorization"] = "Bearer " + token
            
        }
        
        let Params = [
            "part":"id, snippet",
            "mine":"true"
        ]
        
        Alamofire.request(.GET,url, parameters: Params,headers:  header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                if let result = response.result.value {
                    let json=JSON(result)
                    for (_, object) in json["items"]
                    {
                        let item=Item(itemData: object)
                        items.append(item)
                    }
                    
                    completion(success: true, result: items)
                }
                else{
                    completion(success: false, result: nil)
                }
        }
    }
}

