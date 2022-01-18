//
//  NoticeVC.swift
//  Traystorage
//
//  Created by crm on 2022/01/16.
//

import Foundation

class NoticeVC: BaseVC {
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
