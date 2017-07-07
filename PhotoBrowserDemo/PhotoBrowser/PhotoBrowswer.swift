//
//  PhotoBrowswer.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class PhotoBrowswer {
    class func create() -> PhotoBrowserViewController {
        let story = UIStoryboard(name: "PhotoBrowserViewController", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PhotoBrowserViewController") as! PhotoBrowserViewController
        return vc
    }
}
