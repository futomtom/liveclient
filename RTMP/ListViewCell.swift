//
//  ListViewCell.swift
//  CodeTest2
//
//  Created by alexfu on 3/12/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit
import Kingfisher


class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var scheduledDate: UILabel!
    @IBOutlet weak var ScheduledTime: UILabel!

    @IBOutlet weak var thumbImage: UIImageView!
    
    var shadowLayer: CALayer! = nil
    let cornerRadius: CGFloat = 2
    



    

    func renderData(item: Item) {
        print("\(item.snippet.scheduledDate)")
        scheduledDate.text = item.snippet.scheduledDate
        ScheduledTime.text = item.snippet.scheduledTime
        thumbImage.kf_setImageWithURL(NSURL(string:item.snippet.ThumbnailURL!)!)
        title.text=item.snippet.title

    }
}
