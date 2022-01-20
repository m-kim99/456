//
//  ContactusVC.swift
//  Traystorage
//

import Foundation

class ContactusVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    override func removeFromParent() {
    }
    
    func initVC() {
    }

    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
}
