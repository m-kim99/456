import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit
//import Material

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
    @IBOutlet weak var lblDownTime: CountDownTimeLabel!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initVC() {
        if authType == AuthType.phone {
            lblAuthMedia.text = String.init(format: "+86 %@", authMedia)
        } else {
            lblAuthMedia.text = authMedia
        }
    }
    
    override func hideKeyboard() {
        tfPhoneNumber.resignFirstResponder()
        tfCertificationNumber.resignFirstResponder()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
    }
    
    private func onPhoneAuthSent() {
        self.view.showToast("signup_phone_verify_success"._localized)
        lblDownTime.startCountDownTimer()
    }
    
    private func onPhoneAuthDuplicated() {
        AlertDialog.show(self, title:"signup_duplicated_phone"._localized, message: "")
    }
}

//
// MARK: - Action
//
extension SignupAuthCodeVC: BaseAction {
    @IBAction func onClickPhoneAuth(_ sender: Any) {
        hideKeyboard()
        if let phoneNumber = tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phoneNumber.isEmpty {
            sendPhoneAuth(phoneNumber)
        } else {
            self.view.showToast("Please input your phone number.")
        }
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        hideKeyboard()
//        verifyCertKey()
    }
    
    @IBAction func onClickConfirmCertNum(_ sender: Any) {
        guard let code = tfCertificationNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), !code.isEmpty else {
            return
        }

        verifyCode(code)
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
        if textField == tfCertificationNumber, newLen > 8 {
            return false
        }

        return true
    }
}

//
// MARK: - Navigation
//
extension SignupAuthCodeVC: BaseNavigation {
    private func goNext(phone: String, code: Int) {
        let vc = SignupAgreeTerms(nibName: "vc_signup_agree_terms", bundle: nil)
//        vc.authType = authType
//        vc.authMedia = authMedia
        var params: [String: Any] = [:]
        for (k, v) in self.params {
            params[k] = v
        }
        
        params["phone"] = phone
        params["code"] = code.description
        self.pushVC(vc, animated: true, params: params)
    }
}

//
// MARK: - RestApi
//
extension SignupAuthCodeVC: BaseRestApi {
    private func sendPhoneAuth(_ phone: String) {
        SVProgressHUD.show()
        if authType == AuthType.phone {
            Rest.request_code(phoneNumber: phone, success: {
                [weak self](result) in
                SVProgressHUD.dismiss()
                guard let ret = result else {
                    return
                }

                if ret.result == 0 {
                    self?.onPhoneAuthSent()
                } else if ret.result == 206 {
                    self?.onPhoneAuthDuplicated()
                } else {
                    self?.view.showToast(ret.msg)
                }
            }, failure: { _, msg in
                SVProgressHUD.dismiss()
                self.view.showToast(msg)
            })
        } else {
            Rest.sendCertKey(email: authMedia, success: { (result) in
                SVProgressHUD.dismiss()

                let messageEmail = getLangString("dialog_auth_code_email_sent") + "\n\n\n" + self.authMedia

                ConfirmDialog.show(self, title:getLangString("send_success"), message: messageEmail, showCancelBtn : false){

                }
            }, failure: { _, msg in
                SVProgressHUD.dismiss()
                self.view.showToast(msg)
            })
        }
    }
    
    private func verifyCode(_ code: String) {
        guard let phone = tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phone.isEmpty else {
            return
        }

        SVProgressHUD.show()
        
        if authType == AuthType.phone {
            Rest.verifyPhoneCode(phone: phone, code: code, isContinue: 1, success: { [weak self](result) in
                SVProgressHUD.dismiss()
                guard let result = result else {
                    return
                }
                
                if result.result == 0 {
                    let phoneVerify = result as! ModelPhoneVerify
                    self?.goNext(phone: phone, code: phoneVerify.code)
                } else {
                    self?.view.showToast(result.msg)
                }
                
            }, failure: { [weak self](_, msg) in
                SVProgressHUD.dismiss()
                self?.view.showToast(msg)
            })
        } else {
//            Rest.verifyCertKey(email: authMedia, certKey: certKey, success: { (result) in
//                SVProgressHUD.dismiss()
//                self.goNext()
//            }, failure: { _, msg in
//                SVProgressHUD.dismiss()
//                self.view.showToast(msg)
//            })
        }
    }
}
