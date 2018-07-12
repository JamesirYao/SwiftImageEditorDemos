//
//  ViewController.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 11/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit

enum ScrollDirection : Int {
    case left
    case right
    case none
}

class ViewController: UIViewController, UIScrollViewDelegate {

    var topImage: UIImageView!
    var bottomImage: UIImageView!
    var scrollview: UIScrollView!
    var currentIndex: Int!
    
    lazy var filteredImages : [UIImage] = {
        return [UIImage(named: "defaultPhoto")!,
                UIImage(named: "defaultPhoto1")!,
                UIImage(named: "defaultPhoto2")!,
                UIImage(named: "defaultPhoto3")!]
    }()
    
    // to check direction
    var initialContentOffset: CGFloat!
    var initFinished = false
    
    var currentDirection: ScrollDirection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.currentIndex = 0
        self.currentDirection = ScrollDirection.none
        
        self.bottomImage = UIImageView()
        self.bottomImage.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        self.bottomImage.image = nil
        self.bottomImage.contentMode = .scaleAspectFit
        self.view.addSubview(bottomImage)
        
        self.topImage = UIImageView()
        self.topImage.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        self.topImage.image = filteredImages[0]
        self.topImage.contentMode = .scaleAspectFit
        self.view.addSubview(topImage)
        
        self.scrollview = UIScrollView()
        self.scrollview.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        self.scrollview.delegate = self
        self.scrollview.contentSize = CGSize(width: 3*self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(scrollview)
        
        self.scrollview.bounces = false
        self.scrollview.alwaysBounceHorizontal = false
        self.scrollview.isPagingEnabled = true
        self.scrollview.contentOffset = CGPoint(x: self.view.bounds.width, y: 0)
        
        self.initialContentOffset = self.view.bounds.width
        
        applyMask(maskRect:CGRect(
            x: self.view.bounds.width-scrollview.contentOffset.x,
            y: 0,
            width: self.topImage.frame.width,
            height: self.topImage.frame.height
        ))
        
        initFinished = true
        
    }
    
    func applyMask(maskRect: CGRect!){
//        print("mask = \(maskRect)")
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let path: CGPath = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        topImage.layer.mask = maskLayer
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.initialContentOffset = scrollView.contentOffset.x
        
        print("Begin Dragging: currentIndex = \(self.currentIndex)")
    }
    
    func rightIndex(index: Int) -> Int {
        if (index == filteredImages.count-1) {
            return 0
        }
        return index + 1
    }
    
    func leftIndex(index: Int) -> Int {
        if (index == 0) {
            return filteredImages.count - 1
        }
        return index - 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (!initFinished) {return}
        
        if (self.initialContentOffset < scrollView.contentOffset.x && !(currentDirection==ScrollDirection.right)) {
            print("right")
            self.bottomImage.image = filteredImages[rightIndex(index: currentIndex)]
            self.topImage.image = filteredImages[currentIndex]
            self.currentDirection = ScrollDirection.right
        }
        else if (self.initialContentOffset > scrollView.contentOffset.x && !(currentDirection==ScrollDirection.left)) {
            print("left")
            self.bottomImage.image = filteredImages[leftIndex(index: currentIndex)]
            self.topImage.image = filteredImages[currentIndex]
            self.currentDirection = ScrollDirection.left
        }
        
        applyMask(maskRect: CGRect(
            x: self.view.bounds.width-scrollView.contentOffset.x,
            y: 0,
            width: self.topImage.frame.width,
            height: self.topImage.frame.height
        ))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (self.scrollview.contentOffset.x > self.initialContentOffset) {
            self.currentIndex = rightIndex(index: self.currentIndex)
        }
        else if (self.scrollview.contentOffset.x < self.initialContentOffset) {
            self.currentIndex = leftIndex(index: self.currentIndex)
        }
        print("EndDecelerating: currentIndex = \(self.currentIndex)")
        self.currentDirection = ScrollDirection.none
        self.scrollview.contentOffset.x = initialContentOffset
        self.topImage.image = filteredImages[currentIndex]
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    


}

