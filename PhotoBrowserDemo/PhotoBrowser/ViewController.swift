//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = PhotoBrowswer.create()
        present(vc, animated: false, completion: nil)
    }

}

