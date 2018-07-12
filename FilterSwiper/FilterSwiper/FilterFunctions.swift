//
//  FilterFunctions.swift
//  FilterSwiper
//
//  Created by Jamesir Yao on 12/7/18.
//  Copyright © 2018 Jamesir Yao. All rights reserved.
//

import UIKit

func getFilteredImage(image: UIImage, filterName: String) -> UIImage? {
    
    let ciContext = CIContext(options: nil)
    let coreImage = CIImage(image: image)
    let filter = CIFilter(name: filterName)
    filter!.setDefaults()
    filter!.setValue(coreImage, forKey: kCIInputImageKey)
    let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
    let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
    let filterImage = UIImage(cgImage: filteredImageRef!)
    
    return filterImage
}

