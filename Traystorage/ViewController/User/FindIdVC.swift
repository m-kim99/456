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
//        hideError()
    }
    
    private func enableReset(_ enable: Bool) {
        btnReset.isEnabled = enable
    }
    
    private func isValidInput() {
        guard let phoneNumber = tfPhonenumber.text, !phoneNumber.isEmpty else {
            enableReset(false)
            return
        }
        
        enableReset(true)
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
    
    @IBAction func onClickAuthRequest(_ sender: Any) {
        hideKeyboard()
        guard let phoneNumber = tfPhonenumber.text, !phoneNumber.isEmpty else {
            self.view.showToast("Please input your phone number!")
            return
        }
        
        AlertDialog.show(self, title: "Alert", message: "This is not a registered mobile phone number. Please check your mobile phone number.")
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
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
