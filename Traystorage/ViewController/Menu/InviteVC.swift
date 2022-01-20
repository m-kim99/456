//
//  InviteVC.swift
//  Traystorage
//

import Foundation

class InviteVC: BaseVC {
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
