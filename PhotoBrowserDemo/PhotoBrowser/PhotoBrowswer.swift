//
//  PhotoBrowswer.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Tooxen. All rights reserved.
//

import UIKit

class PhotoBrowswer {
    class func create(images: [UIImage]) -> PhotoBrowserViewController {
        let story = UIStoryboard(name: "PhotoBrowserViewController", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PhotoBrowserViewController") as! PhotoBrowserViewController
        vc.images = images
        return vc
    }
    
    class func create(urls: [URL]) -> PhotoBrowserViewController {
        let story = UIStoryboard(name: "PhotoBrowserViewController", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PhotoBrowserViewController") as! PhotoBrowserViewController
        vc.urls = urls
        return vc
    }
    
    private static func urlToData(_ url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}
