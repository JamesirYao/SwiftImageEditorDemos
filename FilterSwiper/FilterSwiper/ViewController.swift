//
//  ViewController.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 11/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate {

    var filterSwiperView : FilterSwiperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.frame
        self.filterSwiperView = FilterSwiperView(frame: frame, originalImage: UIImage(named: "defaultPhoto")!, filterNames:[
            "CIPhotoEffectFade",
            "CIPhotoEffectInstant",
            "CIPhotoEffectMono",
            "CIPhotoEffectNoir"
        ])
        self.view.addSubview(filterSwiperView)
    }

}

