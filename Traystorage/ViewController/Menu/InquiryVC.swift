//
//  InquiryVC.swift
//  Traystorage
//
//  Created by crm on 2022/01/16.
//

import Foundation

class InquiryVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    override func removeFromParent() {
    }
    
    func initVC() {
    }

    @IBAction func onContactus(_ sender: Any) {
        self.pushVC(ContactusVC(nibName: "vc_contactus", bundle: nil), animated: true)
    }

    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
}
