import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

// signup 2nd screen
class SignupAuthCodeVC: BaseVC {
    @IBOutlet weak var lblAuthMedia: UIFontLabel!
    @IBOutlet weak var lblSent: UIFontLabel!
    @IBOutlet weak var lblInput: UIFontLabel!
    @IBOutlet weak var btnResend: UIFontButton!
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfCertificationNumber: UITextField!
    
    @IBOutlet weak var btnNext: UIFontButton!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initLang()
//        initVC()
    }
    
    private func initLang() {
//        lblTitle.text = getLangString("signup_auth_code_input")
//        lblSent.text = getLangString("signup_sent")
//        lblInput.text = getLangString("signup_input_auth_code")
//
//        btnResend.setTitle(getLangString("signup_code_resend"), for: .normal)
//
//        tfAuthCode.placeholder = getLangString("signup_auth_code_hint")
//
//        lblMember.text = getLangString("signup_member_1")
//        btnLogin.setTitle(getLangString("signup_member_2"), for: .normal)
//
//        btnNext.setTitle(getLangString("signup_next"), for: .normal)
//        btnLogin.setUnderlineTitle(getLangString("guide_btn_login"), font: AppFont.robotoRegular(11), color: AppColor.black, for: .normal)
    }
    
    private func initVC() {
        if authType == AuthType.phone {
            lblAuthMedia.text = String.init(format: "+86 %@", authMedia)
        } else {
            lblAuthMedia.text = authMedia
        }
        hideError()
        enableNext(false)
    }
    
    private func enableNext(_ enable: Bool) {
//        btnNext.isEnabled = enable
//        btnNext.backgroundColor = enable ? AppColor.black : AppColor.gray
    }
    
    private func showError(_ msg: String) {
//        tfAuthCode.borderColor = AppColor.error
//        lblError.isHidden = false
//        lblError.text = msg
    }
    
    private func hideError() {
//        tfAuthCode.borderColor = AppColor.gray
//        lblError.isHidden = true
    }
    
    private func hideKeyboard() {
        tfPhoneNumber.resignFirstResponder()
        tfCertificationNumber.resignFirstResponder()
    }

}

//
// MARK: - Action
//
extension SignupAuthCodeVC: BaseAction {
    @IBAction func onBack(_ sender: Any) {
        hideKeyboard()
        popVC()
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onClickResend(_ sender: Any) {
        hideKeyboard()
        sendCertKey()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        hideKeyboard()
        verifyCertKey()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if tfPhoneNumber.text!.isEmpty || tfCertificationNumber.text!.count != 4 {
            self.enableNext(false)
        } else {
            enableNext(true)
        }
    }
}

//
// MARK: - UITextFieldDelegate
//
extension SignupAuthCodeVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let strText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        let strNSText: NSString = strText as NSString
//        if (textField == tfAuthCode) {
//            if (strNSText.length > 4) {
//                return false
//            }
//        }
        return true
    }
}

//
// MARK: - Navigation
//
extension SignupAuthCodeVC: BaseNavigation {
    private func goNext() {
        let vc = SignupAgreeTerms(nibName: "vc_signup_agree_terms", bundle: nil)
//        vc.authType = authType
//        vc.authMedia = authMedia
//        vc.authCode = tfAuthCode.text!
        self.pushVC(vc, animated: true)
    }
}

//
// MARK: - RestApi
//
extension SignupAuthCodeVC: BaseRestApi {
    private func sendCertKey() {
//        SVProgressHUD.show()
//        if authType == AuthType.phone {
//            Rest.sendCertKey(phone: authMedia, success: { (result) in
//                SVProgressHUD.dismiss()
//
//                let messagePhone = getLangString("dialog_auth_code_phone_sent") + "\n\n\n" + self.authMedia
//
//                ConfirmDialog.show(self, title:getLangString("send_success"), message: messagePhone, showCancelBtn : false){
//
//                }
//            }, failure: { _, msg in
//                SVProgressHUD.dismiss()
//                self.view.showToast(msg)
//            })
//        } else {
//            Rest.sendCertKey(email: authMedia, success: { (result) in
//                SVProgressHUD.dismiss()
//
//                let messageEmail = getLangString("dialog_auth_code_email_sent") + "\n\n\n" + self.authMedia
//
//                ConfirmDialog.show(self, title:getLangString("send_success"), message: messageEmail, showCancelBtn : false){
//
//                }
//            }, failure: { _, msg in
//                SVProgressHUD.dismiss()
//                self.view.showToast(msg)
//            })
//        }
    }
    
    private func verifyCertKey() {
//        SVProgressHUD.show()
//        let certKey = tfAuthCode.text
//        if authType == AuthType.phone {
//            Rest.verifyCertKey(phone: authMedia, certKey: certKey, success: { (result) in
//                SVProgressHUD.dismiss()
//                self.goNext()
//            }, failure: { _, msg in
//                SVProgressHUD.dismiss()
//                self.view.showToast(msg)
//            })
//        } else {
//            Rest.verifyCertKey(email: authMedia, certKey: certKey, success: { (result) in
//                SVProgressHUD.dismiss()
                self.goNext()
//            }, failure: { _, msg in
//                SVProgressHUD.dismiss()
//                self.view.showToast(msg)
//            })
//        }
    }
}
