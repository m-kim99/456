import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class FindIdVC: BaseVC {
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
    
    @IBAction func onClickConfirm(_ sender: Any) {
        hideKeyboard()
//        resetPwd()
        pushVC(CheckIdVC(nibName: "vc_check_id", bundle: nil), animated: true)

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
extension FindIdVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        tfEmail.resignFirstResponder()
        resetPwd()
        return true
    }
}

//
// MARK: - RestApi
//
extension FindIdVC: BaseRestApi {
    func resetPwd() {
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
