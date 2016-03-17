//
//  Item.swift
//  CodeTest2
//
//  Created by alexfu on 3/12/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON




struct Item
{

    var snippet : Snippet!
    var boundStreamId :String!
    var streamName : String=""
    var ingestionAddress:String=""
    
    init( itemData:JSON ){
        if let StreamId = itemData["contentDetails"]["boundStreamId"].string
        {
            boundStreamId=StreamId
            snippet=Snippet(json: itemData["snippet"])
        }
    }
}

extension String {
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self[start..<end]
    }
}



class Snippet{
    
    var channelId : String!
    var descriptionField : String!
    var isDefaultBroadcast : Bool!
    var publishedAt : String!
    var scheduledDate:String!
    var scheduledTime:String!
    var ThumbnailURL :String!
  

    
    
    
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(json: JSON!){
        if json == nil{
            return
        }
        
        channelId = json["channelId"].stringValue
        descriptionField = json["description"].stringValue
        isDefaultBroadcast = json["isDefaultBroadcast"].boolValue
        publishedAt = json["publishedAt"].stringValue
        let scheduledStartTime = json["scheduledStartTime"].stringValue
        scheduledDate=scheduledStartTime.substring(0, length: 10)
        //2016-03-14T10:00:00.000Z
        scheduledTime=scheduledStartTime.substring(11, length: 8)
        title = json["title"].stringValue
        ThumbnailURL = json["thumbnails"]["default"]["url"].stringValue
       
    }
    
}
