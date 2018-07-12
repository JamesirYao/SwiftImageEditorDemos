//
//  FilterSwiperView.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 11/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit

class FilterSwiperViewController : UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
//    var imageView : UIImageView!

    var topImage: UIImageView!
    var bottomImage: UIImageView!
    
    lazy var filterViewControllers : [FilterViewController] = {
        return [FilterViewController(filter: CIFilter(name: "CIPhotoEffectChrome")!, index: 0),
                FilterViewController(filter: CIFilter(name: "CIPhotoEffectFade")!, index: 1),
                FilterViewController(filter: CIFilter(name: "CIPhotoEffectInstant")!, index: 2)]
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var scrollView : UIScrollView!
        for subView in view.subviews {
            if let sv = subView as? UIScrollView {
                sv.delegate = self
                scrollView = sv
                break
            }
        }
        
        self.bottomImage = UIImageView()
        self.bottomImage.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        self.bottomImage.image = UIImage(named: "defaultPhoto1")!
        self.bottomImage.contentMode = .scaleAspectFit
        self.view.addSubview(bottomImage)
        
        self.topImage = UIImageView()
        self.topImage.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        self.topImage.image = UIImage(named: "defaultPhoto")!
        self.topImage.contentMode = .scaleAspectFit
        self.view.addSubview(topImage)
        
//        let bound = UIScreen.main.bounds
//        let boundFrame = CGRect(origin: CGPoint.zero, size: bound.size)
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "defaultPhoto")!)
//        self.imageView = UIImageView()
//        self.imageView.frame = CGRect(origin: CGPoint.zero, size: boundFrame.size)
//        self.imageView.contentMode = .scaleAspectFit
//        self.imageView.image = UIImage(named: "defaultPhoto")!
//        self.view.addSubview(imageView)
        
        filterViewControllers[0].view.backgroundColor = UIColor(displayP3Red: 0.5, green: 0, blue: 0, alpha: 0.1)
        filterViewControllers[1].view.backgroundColor = UIColor(displayP3Red: 0, green: 0.5, blue: 0, alpha: 0.1)
        filterViewControllers[2].view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0.5, alpha: 0.1)
        
        applyMask(maskRect:
            CGRect(x: self.view.bounds.width,
                   y: 0,
                   width: scrollView.contentSize.width,
                   height: scrollView.contentSize.height)
        )
//
        
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([filterViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! FilterViewController
        var index : Int!
        if (vc.index == filterViewControllers.count - 1) {
            index = 0
        }
        else {
            index = vc.index + 1
        }
//        self.imageView.sendSubview(toBack: self.filterViewControllers[index].view)
        return filterViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! FilterViewController
        var index : Int!
        if (vc.index == 0) {
            index = filterViewControllers.count - 1
        }
        else {
            index = vc.index - 1
        }
//        self.imageView.sendSubview(toBack: self.filterViewControllers[index].view)
        return filterViewControllers[index]
    }
    
    func applyMask(maskRect: CGRect!){
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let path: CGPath = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        topImage.layer.mask = maskLayer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
//        var percentComplete: CGFloat
//        percentComplete = fabs(point.x - view.frame.size.width)/view.frame.size.width
//        print("percentComplete: %f", percentComplete)
        
        applyMask(maskRect: CGRect(
            x: self.view.bounds.width-scrollView.contentOffset.x,
            y: scrollView.contentOffset.y,
            width: scrollView.contentSize.width,
            height: scrollView.contentSize.height
        ))
    }
    
}

