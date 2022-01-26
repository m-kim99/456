//
//  NoticeVC.swift
//  Traystorage
//

import Foundation
import UIKit
import SVProgressHUD

class NoticeDetailVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noticeID = params["id"] as! Int
        loadNoticeList(noticeID: noticeID)
    }
    
    func initVC() {

    }
}

//
// MARK: - RestApi
//
extension NoticeDetailVC: BaseRestApi {
    func loadNoticeList(noticeID: Int) {
        SVProgressHUD.show()
        Rest.getNotice(noticeID: noticeID, success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
                
            } else {
                self?.view.showToast(ret.msg)
            }
        }, failure: { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        })
    }
}
