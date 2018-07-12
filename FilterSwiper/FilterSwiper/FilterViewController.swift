//
//  FilterViewController.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 11/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var filter: CIFilter!
    var index: Int!
    
    convenience init(filter: CIFilter, index: Int) {
        self.init()
        self.filter = filter
        self.index = index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIVisualEffect()
        
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)
        
//        effectView.effect = nil
        effectView.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        view.addSubview(effectView)
        
        let filterLayer = CALayer()
        filterLayer.frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        filterLayer.masksToBounds = true
        if let filter = filter {
            filterLayer.backgroundFilters = [filter]
        }
        effectView.layer.addSublayer(filterLayer)

//        self.view.layer.addSublayer(effectView.layer)
        
//        if let filter = filter {
//            self.view.layer.backgroundFilters = [filter]
//            self.view.layer.addSublayer(effectView.layer)
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
