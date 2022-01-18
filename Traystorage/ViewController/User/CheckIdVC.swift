import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class CheckIdVC: BaseVC {
    
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
        resetPwd()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        hideKeyboard()
        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
}


//
// MARK: - RestApi
//
extension CheckIdVC: BaseRestApi {
    func resetPwd() {
        SVProgressHUD.show()
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
