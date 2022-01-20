import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class SignupVC: BaseVC {
    @IBOutlet weak var lblTitle: UIFontLabel!
    
    @IBOutlet weak var btnTabPhone: UIButton!
    @IBOutlet weak var btnTabEmail: UIButton!
    
//    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordConfirm: UITextField!
    
    @IBOutlet weak var vwInput: UIView!
    @IBOutlet weak var vwPhoneInput: UIView!
    @IBOutlet weak var lblError: UILabel!
    
    @IBOutlet weak var lblMember: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDuplicateCheck: UIButton!
    
    private var curTab = AuthType.phone
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initLang()
//        initVC()
    }
    
    private func initLang() {
//        lblTitle.text = getLangString("signup_phone_or_email")
//
//        btnTabPhone.setTitle(getLangString("signup_tab_phone"), for: .normal)
//        btnTabEmail.setTitle(getLangString("signup_tab_email"), for: .normal)
//
//        lblMember.text = getLangString("signup_member_1")
//        btnLogin.setTitle(getLangString("signup_member_2"), for: .normal)
//
//        tfPhone.placeholder = getLangString("signup_phone_hint")
//        tfEmail.placeholder = getLangString("signup_email_hint")
//        tfPhone.setLeftPaddingPoints(10.0)
//        tfPhone.setRightPaddingPoints(10.0)
//        tfEmail.setLeftPaddingPoints(10.0)
//        tfEmail.setRightPaddingPoints(10.0)
        
//        btnNext.setTitle(getLangString("signup_next"), for: .normal)
//        btnLogin.setUnderlineTitle(getLangString("guide_btn_login"), font: AppFont.robotoRegular(11), color: AppColor.black, for: .normal)
    }
    
    private func initVC() {
//        changeTab(AuthType.phone)
//        enableNext(false)
        hideError()
    }
    
    private func changeTab(_ tab: AuthType) {
//        curTab = tab
//
////        vwPhoneLine.backgroundColor = (tab == AuthType.phone) ? AppColor.black : AppColor.signup_tab_line
////        vwEmailLine.backgroundColor = (tab == AuthType.email) ? AppColor.black : AppColor.signup_tab_line
////
////        btnTabPhone.setTitleColor(tab == AuthType.phone ? AppColor.black : AppColor.gray, for: .normal)
////        btnTabEmail.setTitleColor(tab == AuthType.email ? AppColor.black : AppColor.gray, for: .normal)
//
//        vwPhoneInput.isHidden = !(tab == AuthType.phone)
//        tfEmail.isHidden = !(tab == AuthType.email)
//
//        hideError()
//        enableNext(false)
//        tfPhone.text = ""
//        tfEmail.text = ""
    }
    
    private func enableNext(_ enable: Bool) {
        btnNext.isEnabled = enable
    }
    
    private func showError(_ type: AuthType) {
//        vwInput.borderColor = AppColor.error
//        lblError.isHidden = false
//        if type == AuthType.phone {
//            lblError.text = getLangString("signup_phone_error")
//        } else {
//            lblError.text = getLangString("signup_email_error")
//        }
    }
    
    private func hideError() {
//        vwInput.borderColor = AppColor.gray
//        lblError.isHidden = true
    }
    
    private func hideKeyboard() {
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        tfPasswordConfirm.resignFirstResponder()
    }
    
    private func showDialog(_ type: AuthType) {
//        let messagePhone = getLangString("dialog_auth_code_phone_sent") + "\n\n\n" + tfPhone.text!
//        
//        let messageEmail = getLangString("dialog_auth_code_email_sent") + "\n\n\n" + tfEmail.text!
//        
//        ConfirmDialog.show(self, title:getLangString("send_success"), message: curTab == AuthType.phone ? messagePhone : messageEmail, showCancelBtn : false){
//            self.goNext()
//        }
    }
    
    
    @IBAction func textFieldDidChange(_ sender: Any) {
//        let phone = tfPhone.text
        if let email = tfEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), email.count > 0 {
            hideError()
            enableNext(true)
            btnDuplicateCheck.isHidden = false
        } else {
//            showError(AuthType.email)
            enableNext(false)
            btnDuplicateCheck.isHidden = true
        }
    }
}

//
// MARK: - Action
//
extension SignupVC: BaseAction {
    @IBAction func onBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onTabPhone(_ sender: Any) {
        changeTab(AuthType.phone)
    }
    
    @IBAction func onTabEmail(_ sender: Any) {
        changeTab(AuthType.email)
    }
    
    @IBAction func onNext(_ sender: Any) {
//        if curTab == AuthType.phone {
//            sendCertKey(phone: tfPhone.text!)
//        } else {
//            sendCertKey(email: tfEmail.text!)
//        }
        
        hideKeyboard()
        goNext()
    }
    
    @IBAction func onClickDuplicate(_ sender: Any) {
        guard let newID = tfEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !newID.isEmpty else {
            self.view.showToast("Please input your ID.")
            return
        }
        
        if newID.count < 4 {
            self.view.showToast("Please input your ID 4+ characters.")
            return
        }
        
        AlertDialog.show(self, title: "Duplicated id", message: "Please input another")
    }
}

//
// MARK: - Navigation
//
extension SignupVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfEmail, newLen > 20 {
            return false
        }
        if textField == tfPassword, newLen > 20 {
            return false
        }
        
        if textField == tfPasswordConfirm, newLen > 20 {
            return false
        }

        return true
    }
}

//
// MARK: - Navigation
//
extension SignupVC: BaseNavigation {
    private func goNext() {
        let vc = SignupAuthCodeVC(nibName: "vc_signup_authcode", bundle: nil)
//        vc.authType = curTab
//        vc.authMedia = (curTab == AuthType.phone) ? tfPhone.text! : tfEmail.text!
        self.pushVC(vc, animated: true)
    }
}

//
// MARK: - RestApi
//
extension SignupVC: BaseRestApi {
    private func sendCertKey(email: String) {
//        SVProgressHUD.show()
//        Rest.sendCertKey(email: email, success: { (result) in
//            SVProgressHUD.dismiss()
//            self.showDialog(self.curTab)
//        }, failure: { _, msg in
//            SVProgressHUD.dismiss()
//            self.view.showToast(msg)
//        })
    }
    
    private func sendCertKey(phone: String) {
//        SVProgressHUD.show()
//        Rest.sendCertKey(phone: phone, success: { (result) in
//            SVProgressHUD.dismiss()
//            self.showDialog(self.curTab)
//        }, failure: { _, msg in
//            SVProgressHUD.dismiss()
//            self.view.showToast(msg)
//        })
    }
}
