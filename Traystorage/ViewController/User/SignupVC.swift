import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit
//import Material

class SignupVC: BaseVC {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnTabPhone: UIButton!
    @IBOutlet weak var btnTabEmail: UIButton!
    
    @IBOutlet weak var tfID: UITextField!
    
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
    

    
    private func hideError() {
//        vwInput.borderColor = AppColor.gray
//        lblError.isHidden = true
    }
    
    override func hideKeyboard() {
        tfID.resignFirstResponder()
        tfPassword.resignFirstResponder()
        tfPasswordConfirm.resignFirstResponder()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
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
        if let userID = tfID.text?.trimmingCharacters(in: .whitespacesAndNewlines), userID.count > 0 {
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
        guard let newID = tfID.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newID.isEmpty else {
            self.view.showToast("signup_id_empty_alert"._localized)
            return
        }
        
        if newID.count < 4 {
            self.view.showToast("signup_id_less4"._localized)
            return
        }
        
        AlertDialog.show(self, title: "signup_duplicated_id_title"._localized, message: "signup_duplicated_id_detail"._localized)
    }
}

//
// MARK: - Navigation
//
extension SignupVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfID, newLen > 20 {
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
        guard let userID = tfID.text?.trimmingCharacters(in: .whitespacesAndNewlines), !userID.isEmpty else {
            return
        }
        
        guard let pass = tfPassword.text, !pass.isEmpty, let passConfirm = tfPasswordConfirm.text, pass == passConfirm else {
            AlertDialog.show(self, title: "password_mismatch_confirm"._localized, message: "")
            return
        }
        
        
        let vc = SignupAuthCodeVC(nibName: "vc_signup_authcode", bundle: nil)
//        vc.authType = curTab
//        vc.authMedia = (curTab == AuthType.phone) ? tfPhone.text! : tfEmail.text!
        self.pushVC(vc, animated: true, params: ["id": userID, "pwd": pass])
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
