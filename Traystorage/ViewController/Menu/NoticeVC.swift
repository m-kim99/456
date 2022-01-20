//
//  NoticeVC.swift
//  Traystorage
//

import Foundation
import UIKit

class NoticeVC: BaseVC {
    @IBOutlet weak var tvList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    override func removeFromParent() {
    }
    
    func initVC() {
        tvList.dataSource = self
        tvList.delegate = self
        tvList.register(UINib(nibName: "tvc_notice", bundle: nil), forCellReuseIdentifier: "NoticeTVC")

    }
    
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
}

//
// MARK: - RestApi
//
extension NoticeVC: BaseRestApi {
    func updateList(type: String, alarm_yn: String) {
//        SVProgressHUD.show()
//        Rest.changeAlarm(type: type, alarm_yn: alarm_yn, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            if result?.result == 0 {
//                if type == "push" {
//                    self.user.alarm_push_yn = alarm_yn
//                    self.lblPushAllowValue.text = (self.user.alarm_push_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnPushAllow.isSelected = (self.user.alarm_push_yn == "y")
//                } else {
//                    self.user.alarm_challenge_yn = alarm_yn
//                    self.lblChallengeValue.text = (self.user.alarm_challenge_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnChallengeAlarm.isSelected = (self.user.alarm_challenge_yn == "y")
//                }
//
//                Local.setUser(self.user)
//            }
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
    }
}

//
// MARK: - UITableViewDataSource, UITableViewDelegate
//
extension NoticeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTVC", for: indexPath) //as! NoticeTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushVC(NoticeDetailVC(nibName: "vc_notice_detail", bundle: nil), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
    
}
