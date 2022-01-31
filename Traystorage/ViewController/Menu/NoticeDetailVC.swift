//
//  NoticeVC.swift
//  Traystorage
//

import Foundation
import UIKit
import SVProgressHUD
import WebKit

class NoticeDetailVC: BaseVC {
    
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblRegTime: UIFontLabel!
    @IBOutlet weak var wvContent: WKWebView!
    
    var notice: ModelNotice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadContents()
        
        if let noticeID = params["id"] as? Int {
            loadNotice(noticeID: noticeID)
        } else if let noticeCode = params["code"] as? String {
            loadNotice(noticeCode: noticeCode)
        }
    }
    
    private func loadContents() {
        if let notice = notice {
            lblTitle.text = notice.title
            lblRegTime.text = notice.create_time
            wvContent.loadHTMLString(notice.content, baseURL: nil)
        } else {
            lblTitle.text = nil
            lblRegTime.text = nil
            wvContent.loadHTMLString("", baseURL: nil)
        }
    }
}

//
// MARK: - RestApi
//
extension NoticeDetailVC: BaseRestApi {
    func loadNotice(noticeID: Int) {
        SVProgressHUD.show()
        Rest.getNotice(noticeID: noticeID, success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()

            self?.notice = (result as! ModelNotice)
            self?.loadContents()

        }) { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
    
    func loadNotice(noticeCode: String) {
        SVProgressHUD.show()
        Rest.getNotice(code: noticeCode, success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()

            self?.notice = (result as! ModelNotice)
            self?.loadContents()

        }) { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
}
