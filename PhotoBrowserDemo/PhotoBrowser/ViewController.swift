//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var images: [UIImage] = [#imageLiteral(resourceName: "pic-1.jpeg"), #imageLiteral(resourceName: "pic-2.jpg"), #imageLiteral(resourceName: "pic-3.jpg"), #imageLiteral(resourceName: "pic-4.jpg"), #imageLiteral(resourceName: "pic-5.jpg"), #imageLiteral(resourceName: "pic-6.jpg"), #imageLiteral(resourceName: "pic-7.jpeg"), #imageLiteral(resourceName: "pic-8.jpg"), #imageLiteral(resourceName: "pic-9.jpg"), #imageLiteral(resourceName: "pic-10.jpg")]
    var urls: [URL] = [URL(string: "https://pic.pimg.tw/acatandcats/1386481325-3920179167.jpg")!,
                       URL(string: "http://d36lyudx79hk0a.cloudfront.net/p0/mn/p4/59754d476d1a30a3.jpg")!,
                       URL(string: "http://www.bz55.com/uploads/allimg/120122/1_120122230539_1.jpg")!,
                       URL(string: "http://images.china.cn/attachement/jpg/site1000/20091222/001ec949f8470c9ac6cb02.jpg")!,
                       URL(string: "http://maoup.com.tw/wp-content/uploads/2015/09/4017913244_002177266c_z.jpg")!,
                       URL(string: "http://mag-cosmo-prod-s3.s3.amazonaws.com/legacy/images/lifestyle/154502253.jpg")!,
                       URL(string: "https://buzzorange.com/vidaorange/wp-content/uploads/sites/3/2015/03/tabby-domesticated-petting-e1488563578327.jpg")!,
                       URL(string: "http://pic.pimg.tw/acatandcats/1352942628-2349736107.jpg")!,
                       URL(string: "http://pic.pimg.tw/acatandcats/1345552998-2377764373.jpg")!,
                       URL(string: "http://pic.pimg.tw/acatandcats/1352874561-2317819215.jpg")!,
                       URL(string: "https://i.imgflip.com/tfgut.jpg")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let vc = PhotoBrowswer.create(images: images)
        let vc = PhotoBrowswer.create(urls: urls)
        present(vc, animated: false, completion: nil)
    }

}

