//
//  FilterSwiperView.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 12/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit

enum ScrollDirection : Int {
    case left
    case right
    case none
}

class FilterSwiperView : UIView, UIScrollViewDelegate {
    
    private var topImage: UIImageView!
    private var bottomImage: UIImageView!
    private var scrollview: UIScrollView!
    private var currentIndex: Int!
    
    private var initialContentOffset: CGFloat!
    private var initFinished = false
    
    private var currentDirection: ScrollDirection!
    
    var filterNames : [String]!
    var originalImages : UIImage!
    
    init(frame: CGRect, originalImage: UIImage, filterNames: [String]) {
        self.filterNames = filterNames
        self.originalImages = originalImage
        super.init(frame: frame)
        setupView()
    }

    func setupView() {
        self.currentIndex = 0
        self.currentDirection = ScrollDirection.none
        
        self.bottomImage = UIImageView()
        self.bottomImage.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        self.bottomImage.image = nil
        self.bottomImage.contentMode = .scaleAspectFit
        self.addSubview(bottomImage)
        
        self.topImage = UIImageView()
        self.topImage.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        self.topImage.image = getFilteredImage(image: originalImages, filterName: filterNames[0])
        self.topImage.contentMode = .scaleAspectFit
        self.addSubview(topImage)
        
        self.scrollview = UIScrollView()
        self.scrollview.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        self.scrollview.delegate = self
        self.scrollview.contentSize = CGSize(width: 3*self.frame.width, height: self.frame.height)
        self.scrollview.showsHorizontalScrollIndicator = false
        self.addSubview(scrollview)
        
        self.scrollview.bounces = false
        self.scrollview.alwaysBounceHorizontal = false
        self.scrollview.isPagingEnabled = true
        self.scrollview.contentOffset = CGPoint(x: self.bounds.width, y: 0)
        
        self.initialContentOffset = self.bounds.width
        
        applyMask(maskRect:CGRect(
            x: self.frame.width-scrollview.contentOffset.x,
            y: 0,
            width: self.topImage.frame.width,
            height: self.topImage.frame.height
        ))
        
        initFinished = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyMask(maskRect: CGRect!){
        //        print("mask = \(maskRect)")
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let path: CGPath = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        topImage.layer.mask = maskLayer
    }
    
    
    func rightIndex(index: Int) -> Int {
        if (index == filterNames.count-1) {
            return 0
        }
        return index + 1
    }
    
    func leftIndex(index: Int) -> Int {
        if (index == 0) {
            return filterNames.count - 1
        }
        return index - 1
    }
    
    func getFilteredImageByIndex(index: Int) -> UIImage? {
        return getFilteredImage(image: originalImages, filterName: filterNames[index])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (!initFinished) {return}
        
        if (self.initialContentOffset < scrollView.contentOffset.x && !(currentDirection==ScrollDirection.right)) {
            self.bottomImage.image = getFilteredImageByIndex(index: rightIndex(index: currentIndex))
            self.topImage.image = getFilteredImageByIndex(index: currentIndex)
            self.currentDirection = ScrollDirection.right
        }
        else if (self.initialContentOffset > scrollView.contentOffset.x && !(currentDirection==ScrollDirection.left)) {
            self.bottomImage.image = getFilteredImageByIndex(index: leftIndex(index: currentIndex))
            self.topImage.image = getFilteredImageByIndex(index: currentIndex)
            self.currentDirection = ScrollDirection.left
        }
        
        applyMask(maskRect: CGRect(
            x: self.frame.width-scrollView.contentOffset.x,
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
        self.currentDirection = ScrollDirection.none
        self.scrollview.contentOffset.x = initialContentOffset
        self.topImage.image = getFilteredImageByIndex(index: currentIndex)
    }

}
