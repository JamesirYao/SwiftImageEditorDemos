# SwiftImageEditorDemos
A repository includes several demos used by IOS image editor. 

## FilterSwiper
FilterSwiperView is a subclass of UIView which has a functionalility to switch different filters for a given image. 

![grab-landing-page](https://github.com/JamesirYao/SwiftImageEditorDemos/blob/master/illustration/IMG_7784.GIF)

### Usage
```swift
let frame = self.view.frame
self.filterSwiperView = FilterSwiperView(frame: frame, originalImage: UIImage(named: "defaultPhoto")!, filterNames:[
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectMono",
    "CIPhotoEffectNoir"
])
self.view.addSubview(filterSwiperView)
```
where the parameter frame is the frame of filterSwiperView, originalImage is the image which would be filtered and filterNames are an ordered list of filter names.
