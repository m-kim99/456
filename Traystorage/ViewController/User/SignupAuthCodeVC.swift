import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

// signup 2nd screen
class SignupAuthCodeVC: BaseVC {
    @IBOutlet weak var lblAuthMedia: UILabel!
    @IBOutlet weak var lblSent: UILabel!
    @IBOutlet weak var lblInput: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    @IBOutlet weak var btnAuthPhone: UIButton!
    @IBOutlet weak var btnConfirmCertification: UIButton!
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfCertificationNumber: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    
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
        ConfirmDialog.show(self, title: "If you close the screen membership registeration will be stopped", message: "Are you sure to cancel", showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
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
    
    @IBAction func onClickAuthRequest(_ sender: Any) {
        if let phoneNumber = tfPhoneNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !phoneNumber.isEmpty {
            AlertDialog.show(self, title: "Alarm", message: "This is an already registered 16 mobile phone number.")
        } else {
            self.view.showToast("Please input your phone number.")
        }
    }
    
    @IBAction func onClickConfirmCertNum(_ sender: Any) {
        
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
//        if tfPhoneNumber.text!.isEmpty || tfCertificationNumber.text!.count != 4 {
//            btnNext.isEnabled = false
//        } else {
//            btnNext.isEnabled = true
//        }
    }
}

//
// MARK: - UITextFieldDelegate
//
extension SignupAuthCodeVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLen = (textField.text?.count ?? 0) - range.length + string.count
        if textField == tfPhoneNumber, newLen > 11 {
            return false
        }
        if textField == tfCertificationNumber, newLen > 4 {
            return false
        }

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
