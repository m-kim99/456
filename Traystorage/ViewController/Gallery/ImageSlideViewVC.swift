//
//  ImageBrowserVC.swift
//  Traystorage
//
//

import Foundation
import ImageSlideshow

class ImageSlideViewVC: BaseVC {
    @IBOutlet weak var imageSliderView: ImageSlideshow!
    @IBOutlet weak var pageIndicator: UILabel!
    
    var modelDocument: ModelDocument!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSliderView.delegate = self
        var images = [InputSource]()
        for i in 0..<modelDocument.imagesUrlList.count {
            if let imageURL = modelDocument.imagesUrlList[i] {
                images.append(KingfisherSource(url: imageURL))
            } else if let image = modelDocument.images[i] {
                images.append(ImageSource(image: image))
            }
        }
        
        for i in 0..<modelDocument.imagesUrlList.count {
            if let imageURL = modelDocument.imagesUrlList[i] {
                images.append(KingfisherSource(url: imageURL))
            } else if let image = modelDocument.images[i] {
                images.append(ImageSource(image: image))
            }
        }
        
        imageSliderView.setImageInputs(images)
        pageIndicator.text = "1/\(images.count)"
    }
    
}

extension ImageSlideViewVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        pageIndicator.text = "\(page+1)/\(imageSlideshow.images.count)"
    }
}
