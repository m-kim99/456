import SVProgressHUD
import UIKit

class SettingVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    
    @IBOutlet weak var editID: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var lblVersion: UILabel!
    
    @IBOutlet var vwItems: [UIStackView]!
    private lazy var user: ModelUser = {
        return Rest.user
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    private func initVC() {
        for (index, menu) in vwItems.enumerated() {
            menu.tag = index
            menu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItem(_:))))
        }

        editID.text = user.uid
//        btnChallengeAlarm.isSelected = (user.alarm_challenge_yn == "y")
//        lblVersionValue.text = getLangString("setting_latest_version_using")
    }
    
    //
    // MARK: - ACTION
    //
    @IBAction func onEditPassword(_ sender: Any) {
    }
    
    @objc func onClickItem(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 0:
            self.pushVC(VersionVC(nibName: "vc_version", bundle: nil), animated: true)
            break
        case 1:
            self.pushVC(FaqVC(nibName: "vc_faq", bundle: nil), animated: true)
            break
        case 2:
            self.pushVC(LicenseVC(nibName: "vc_license", bundle: nil), animated: true)
            break
        case 3:
            self.pushVC(TermsVC(nibName: "vc_terms", bundle: nil), animated: true)
            break
        case 4:
            //            self.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true)
            break
        case 5:
            //            self.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true)
            break
        case 6:
            onClickLogout(1);
            break
        case 7:
            self.pushVC(WithdrawalVC(nibName: "vc_withdrawal", bundle: nil), animated: true)
            break
        default:
            break
        }
    }
    
    @IBAction func onClickPwd(_ sender: Any) {
        ConfirmDialog.show(self, title:"setting_password_change_title"._localized, message: "setting_password_change_detail"._localized, showCancelBtn : true) { [weak self]() -> Void in
            self?.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true)
        }
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        ConfirmDialog.show(self, title:"logout_alert_title"._localized, message: "", showCancelBtn : true) { [weak self]() -> Void in
            Local.deleteUser()
            Rest.user = nil
            Local.removeAutoLogin()
            
            if let nv = self?.navigationController {
                let vcs = nv.viewControllers
                for vc in vcs {
//                    if vc is LoginVC {
//                        let logVC = vc as! LoginVC
//                        logVC.resetLoginInputInformation()
//                        nv.popToViewController(vc, animated: true)
//                        break
//                    }
                    
                    if vc is IntroVC {
                        let introVC = vc as! IntroVC
                        introVC.openLogSingupView()
                        nv.popToViewController(vc, animated: true)
                        break
                    }

                }
            }
        }
    }
}

//
// MARK: - RestApi
//
extension SettingVC: BaseRestApi {
    func changeAlarm(type: String, alarm_yn: String) {
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
