//
//  PhotoBrowserViewController.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class PhotoBrowserViewController: UIViewController {

    var images: [UIImage] = [#imageLiteral(resourceName: "pic-1.jpeg"), #imageLiteral(resourceName: "pic-2.jpg"), #imageLiteral(resourceName: "pic-3.jpg"), #imageLiteral(resourceName: "pic-4.jpg"), #imageLiteral(resourceName: "pic-5.jpg"), #imageLiteral(resourceName: "pic-6.jpg"), #imageLiteral(resourceName: "pic-7.jpeg"), #imageLiteral(resourceName: "pic-8.jpg"), #imageLiteral(resourceName: "pic-9.jpg"), #imageLiteral(resourceName: "pic-10.jpg")]
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var browserCollectionView: UICollectionView!
    
    @IBOutlet weak var imageFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var browserFlowLayout: UICollectionViewFlowLayout!
    
    fileprivate var lastItem: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFlowLayout.itemSize = UIScreen.main.bounds.size
        browserFlowLayout.itemSize = CGSize(width: 50, height: 50)
        
    }

    func animateZoomforCell(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.1) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
        }
    }
    
    func animateZoomforCellRemove(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.1) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.5
        }
    }
    
}

extension PhotoBrowserViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            if collectionView == imageCollectionView {
                let item = Int(collectionView.contentOffset.x / collectionView.bounds.width)
                browserCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
                animateZoomforCellRemove(cell: browserCollectionView.cellForItem(at: IndexPath(item: lastItem, section: 0))!)
                animateZoomforCell(cell: browserCollectionView.cellForItem(at: IndexPath(item: item, section: 0))!)
                lastItem = item
            }
        }
    }
    
}

extension PhotoBrowserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case browserCollectionView:
            return images.count
        case imageCollectionView:
            return images.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case browserCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserCell", for: indexPath)
            (cell.viewWithTag(1) as? UIImageView)?.image = images[indexPath.item]
            if indexPath.item == lastItem {
                cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 2
            }
            return cell
        case imageCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
            (cell.viewWithTag(1) as? UIImageView)?.image = images[indexPath.item]
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
}

extension PhotoBrowserViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.viewWithTag(1)
    }
}


