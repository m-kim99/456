import SVProgressHUD
import UIKit

class SettingVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UIFontLabel!
    
    @IBOutlet weak var lblUserInfo: UIFontLabel!
    @IBOutlet weak var lblProfileSetting: UIFontLabel!
    @IBOutlet weak var lblId: UIFontLabel!
    @IBOutlet weak var lblIdValue: UIFontLabel!
    @IBOutlet weak var lblPwd: UIFontLabel!
    @IBOutlet weak var lblPwdValue: UIFontLabel!
    @IBOutlet weak var lblName: UIFontLabel!
    @IBOutlet weak var lblNameValue: UIFontLabel!
    @IBOutlet weak var lblBirth: UIFontLabel!
    @IBOutlet weak var lblBirthValue: UIFontLabel!
    @IBOutlet weak var lblSex: UIFontLabel!
    @IBOutlet weak var lblSexValue: UIFontLabel!
    @IBOutlet weak var lblAlarm: UIFontLabel!
    @IBOutlet weak var lblPushAllow: UIFontLabel!
    @IBOutlet weak var lblPushAllowValue: UIFontLabel!
    @IBOutlet weak var btnPushAllow: UIButton!
    @IBOutlet weak var lblChallenge: UIFontLabel!
    @IBOutlet weak var lblChallengeValue: UIFontLabel!
    @IBOutlet weak var btnChallengeAlarm: UIButton!
    @IBOutlet weak var lblAppInfo: UIFontLabel!
    @IBOutlet weak var lblErrorReport: UIFontLabel!
    @IBOutlet weak var lblUseAgrement: UIFontLabel!
    @IBOutlet weak var lblPrivacy: UIFontLabel!
    @IBOutlet weak var lblVersion: UIFontLabel!
    @IBOutlet weak var lblVersionValue: UIFontLabel!
    @IBOutlet weak var lblLogout: UIFontLabel!
    
//    private lazy var user: ModelUser = {
//        return Rest.user
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLang()
        initVC()
    }
    
    private func initLang() {
        lblPageTitle.text = getLangString("setting")
        lblUserInfo.text = getLangString("setting_userinfo")
        lblProfileSetting.text = getLangString("setting_profile_setting")
        lblId.text = getLangString("setting_id")
        lblPwd.text = getLangString("setting_password")
        lblPwdValue.text = getLangString("setting_change")
        lblName.text = getLangString("setting_name")
        lblBirth.text = getLangString("setting_birth")
        lblSex.text = getLangString("setting_sex")
        lblAlarm.text = getLangString("setting_alarm")
        lblPushAllow.text = getLangString("setting_push_allow")
        lblChallenge.text = getLangString("setting_challenge")
        lblAppInfo.text = getLangString("setting_app_info")
        lblErrorReport.text = getLangString("setting_error_report")
        lblUseAgrement.text = getLangString("setting_use_agreement")
        lblPrivacy.text = getLangString("setting_privacy_policy")
        lblVersion.text = getLangString("setting_version")
        lblLogout.text = getLangString("setting_logout")
    }
    
    private func initVC() {
//        lblNameValue.text = user.name
//        btnChallengeAlarm.isSelected = (user.alarm_challenge_yn == "y")
//        lblVersionValue.text = getLangString("setting_latest_version_using")
    }
    
    //
    // MARK: - ACTION
    //
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickProfileSetting(_ sender: Any) {
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
