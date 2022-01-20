//
//  FaqCVC.swift
//  Traystorage
//

import UIKit

class FaqCVC: UICollectionViewCell {

    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(area: String, selectedArea: String) {
        lblText.text = area
//        vwRoot.cornerRadius = 2
//        if area == selectedArea {
//            vwRoot.borderWidth = 0
//            vwRoot.backgroundColor = AppColor.active
//            lblText.textColor = AppColor.white
//        } else {
//            vwRoot.backgroundColor = AppColor.white
//            vwRoot.borderColor = AppColor.border
//            vwRoot.borderWidth = 1
//            lblText.textColor = AppColor.dark
//        }
    }

}
