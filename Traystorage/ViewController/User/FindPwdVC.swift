import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class FindPwdVC: BaseVC {
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPhonenumber: UITextField!
    @IBOutlet weak var tfCertification: UITextField!
    @IBOutlet weak var btnReset: UIFontButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initLang()
//        initVC()
    }
    
    private func initLang() {
//        lblPwd.text = getLangString("pwd_reset_title")
//        lblPwdDesc.text = getLangString("pwd_reset_desc1")
//        lblError.text = getLangString("signup_email_error")
//        lblBackToFirst.text = getLangString("pwd_reset_desc2")
//        tfEmail.placeholder = getLangString("signup_email_hint")
//        btnReset.setTitle(getLangString("pwd_reset"), for: .normal)
//        btnLogin.setUnderlineTitle(getLangString("guide_btn_login"), font: AppFont.robotoRegular(11), color: AppColor.black, for: .normal)
    }
    
    private func initVC() {
//        tfEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        tfEmail.delegate = self
//
//        hideError()
//        enableReset(false)
    }
    
    private func enableReset(_ enable: Bool) {
        btnReset.isEnabled = enable
        btnReset.backgroundColor = enable ? AppColor.black : AppColor.gray
    }
    
    private func isValidInput() {
        var isValid = true
//        if isValid && tfEmail.text!.isEmpty {
//            isValid = false
//        }
//
//        if isValid && !Validations.email(tfEmail.text!) {
//            isValid = false
//        }
        
        hideError()
        enableReset(isValid)
    }
    
    private func showError(_ msg: String) {
//        tfEmail.borderColor = AppColor.error
//        lblError.isHidden = false
//        lblError.text = msg
    }
    
    private func hideError() {
//        tfEmail.borderColor = AppColor.gray
//        lblError.isHidden = true
    }
    
    private func hideKeyboard() {
        tfID.resignFirstResponder()
        tfPhonenumber.resignFirstResponder()
        tfCertification.resignFirstResponder()
    }
    
    private func onResetSuccess() {
//        let msg = String.init(format: "%@\n%@", getLangString("dialog_pwd_reset"), tfEmail.text!)
//        AlertDialog.show(self, title: getLangString("dialog_pwd_reset_title"), message: msg)
    }
    
    //
    // MARK: - Action
    //
    @IBAction func onClickBack(_ sender: Any) {
        hideKeyboard()
        popVC()
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onReset(_ sender: Any) {
        hideKeyboard()
        
        guard let textID = tfID.text, !textID.isEmpty else {
            self.view.showToast("Please input your ID!")
            return
        }
        
        resetPwd()
    }
    
    @IBAction func onAuthReqest(_ sender: Any) {
        guard let phoneNumber = tfPhonenumber.text, !phoneNumber.isEmpty else {
            self.view.showToast("Please input your phone number!")
            return
        }
        
        AlertDialog.show(self, title: "Alert", message: "This is not a registered mobile phone number. Please check your mobile phone number.")
    }
    
    @IBAction func onLogin(_ sender: Any) {
        hideKeyboard()
        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        isValidInput()
    }
}

//
// MARK: - UITextFieldDelegate
//
extension FindPwdVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        tfEmail.resignFirstResponder()
        resetPwd()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfPhonenumber, newLen > 11 {
            return false
        }

        return true
    }
}

//
// MARK: - RestApi
//
extension FindPwdVC: BaseRestApi {
    func resetPwd() {
        self.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true)
//        SVProgressHUD.show()
//        Rest.resetPwd(email: tfEmail.text, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            self.onResetSuccess()
//        }, failure: { (code, err) -> Void in
//            SVProgressHUD.dismiss()
//            if code == 202 {
//                self.showError(err)
//                return
//            }
//            self.view.showToast(err)
//        })
    }
}
