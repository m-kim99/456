import SVProgressHUD
import UIKit

class SettingVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UIFontLabel!
    
    @IBOutlet weak var editID: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var lblVersion: UIFontLabel!
    
    @IBOutlet var vwItems: [UIStackView]!
    //    private lazy var user: ModelUser = {
//        return Rest.user
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLang()
        initVC()
    }
    
    private func initLang() {
//        lblPageTitle.text = getLangString("setting")
        
    }
    
    private func initVC() {
        for (index, menu) in vwItems.enumerated() {
            menu.tag = index
            menu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItem(_:))))
        }

//        lblNameValue.text = user.name
//        btnChallengeAlarm.isSelected = (user.alarm_challenge_yn == "y")
//        lblVersionValue.text = getLangString("setting_latest_version_using")
    }
    
    //
    // MARK: - ACTION
    //
    @IBAction func onEditPassword(_ sender: Any) {
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
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
        self.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
//        ConfirmDialog.show(self, title:getLangString("setting_logout_confirm_title"), message: getLangString("setting_logout_confirm"), showCancelBtn : true) {
//            Local.deleteUser()
//            Rest.user = nil
//            self.replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
//        }
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
