//
//  ModelDocument.swift
//  Traystorage
//
//

import Foundation
import SwiftyJSON
import UIKit

class ModelDocument: ModelBase {
    var doc_id : Int = -1
    var user_id : Int = -1
    var images: [UIImage?] = []
    var imagesUrlList:[String?] = []
    var title: String = ""
    var content: String = ""
    var tags:[String] = []
    
    var create_time: String = ""
    
    var label: Int = 0
        
    override init() {
        super.init()
    }
    
    override init(_ json: JSON) {
        super.init(json)
        doc_id = json["id"].intValue
        user_id = json["user_id"].intValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        label = json["label"].intValue
        create_time = json["create_time"].stringValue
        
        let tagList = json["tag_list"]
        if tagList != . null {
            for (_, tag) in tagList {
                self.tags.append(tag.stringValue)
            }
        }
        
        let imageList = json["image_list"]
        if imageList != . null {
            for (_, image) in imageList {
                self.addImage(url: image.stringValue)
            }
        }
    }
    
    func addImage(image:UIImage?) {
        images.append(image)
        self.imagesUrlList.append(nil)
    }
    
    func addImage(url: String) {
        images.append(nil)
        self.imagesUrlList.append(url)
    }
    
    func removeImage(at: Int) {
        images.remove(at: at)
        imagesUrlList.remove(at: at)
    }
}


public class ModelDocumentList: ModelList {
    var contents = [ModelDocument]()
    
    override init(_ json: JSON) {
        super.init(json)
        
        let arr = json["document_list"]
        if arr != .null {
            for (_, m) in arr {
                contents.append(ModelDocument(m))
            }
        }
    }
}
