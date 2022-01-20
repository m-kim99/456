//
//  ModelDocument.swift
//  Traystorage
//
//

import Foundation
import UIKit

class ModelDocument: ModelBase {
    var images: [UIImage] = []
    var title: String = ""
    var content: String = ""
    var tags:[String] = []
    
    var label: Int = -1
        
    override init() {
        super.init()
    }
    
}
