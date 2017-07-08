//
//  PhotoBrowserViewController.swift
//  PhotoBrowser
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 Tooxen. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewController: UIViewController {

    var images: [UIImage] = []
    var urls: [URL] = []
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var browserCollectionView: UICollectionView!
    
    @IBOutlet weak var imageFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var browserFlowLayout: UICollectionViewFlowLayout!
    
    fileprivate var lastItem: Int = 0
    fileprivate var nonUpdateItem: [Int] = []
    fileprivate var isURL: Bool {
        return !urls.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFlowLayout.itemSize = UIScreen.main.bounds.size
        browserFlowLayout.itemSize = CGSize(width: 50, height: 50)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageFlowLayout.itemSize = UIScreen.main.bounds.size
        browserFlowLayout.itemSize = CGSize(width: 50, height: 50)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageCollectionView.scrollToItem(at: IndexPath(item: lastItem, section: 0),
                                         at: .left, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.shared().clearMemory()
    }
    
    deinit {
        SDImageCache.shared().clearMemory()
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
            cell.layer.borderWidth = 0
        }
    }
    
    func selectItem(item: Int) {
        (imageCollectionView.cellForItem(at: IndexPath(item: lastItem, section: 0))?.viewWithTag(2) as? UIScrollView)?.setZoomScale(1, animated: false)
        
        browserCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
        if let lastCell = browserCollectionView.cellForItem(at: IndexPath(item: lastItem, section: 0)) {
            animateZoomforCellRemove(cell: lastCell)
        } else {
            nonUpdateItem.append(lastItem)
        }
        
        if let cell = browserCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) {
            animateZoomforCell(cell: cell)
        } else {
            nonUpdateItem.append(item)
        }
        
        imageCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .left, animated: true)
        lastItem = item
    }
    
    func tapImageAction(_ sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 1 {
            browserCollectionView.isHidden = !browserCollectionView.isHidden
        } else {
            let item = Int(imageCollectionView.contentOffset.x / imageCollectionView.bounds.width)
            if let scrollView = (imageCollectionView.cellForItem(at: IndexPath(item: item, section: 0))?.viewWithTag(2) as? UIScrollView) {
                if scrollView.zoomScale > 1 {
                    scrollView.setZoomScale(1, animated: true)
                } else {
                    scrollView.setZoomScale(2, animated: true)
                }
            }
        }
    }
    
}

extension PhotoBrowserViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case browserCollectionView:
            selectItem(item: indexPath.item)
        case imageCollectionView:
            browserCollectionView.isHidden = true
        default:
            break
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            let item = Int(imageCollectionView.contentOffset.x / imageCollectionView.bounds.width)

            if collectionView == imageCollectionView {
                selectItem(item: item)
            } else if collectionView == browserCollectionView {
                if !nonUpdateItem.isEmpty {
                    browserCollectionView.reloadData()
                    nonUpdateItem.removeAll()
                }
            }
        }
    }
    
}

extension PhotoBrowserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case browserCollectionView:
            return isURL ? urls.count : images.count
        case imageCollectionView:
            return isURL ? urls.count : images.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case browserCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowserCell", for: indexPath)
            if isURL {
                (cell.viewWithTag(1) as? UIImageView)?.sd_setImage(with: urls[indexPath.item])
            } else {
                (cell.viewWithTag(1) as? UIImageView)?.image = images[indexPath.item]
            }
            
            if indexPath.item == lastItem {
                cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 2
            } else {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 0
            }
            return cell
            
        case imageCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
            if isURL {
                (cell.viewWithTag(1) as? UIImageView)?.sd_setImage(with: urls[indexPath.item])
            } else {
                (cell.viewWithTag(1) as? UIImageView)?.image = images[indexPath.item]
            }
            if (cell.gestureRecognizers?.isEmpty ?? true) {
                weak var `self` = self
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(self?.tapImageAction))
                tapGes.numberOfTapsRequired = 2
                
                let tapGes2 = UITapGestureRecognizer(target: self, action: #selector(self?.tapImageAction))
                tapGes2.numberOfTapsRequired = 1
                tapGes2.delaysTouchesBegan = true
                tapGes2.require(toFail: tapGes)
                
                cell.addGestureRecognizer(tapGes)
                cell.addGestureRecognizer(tapGes2)
            }
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


