import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class FindPwdVC: BaseVC {
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPhonenumber: UITextField!
    @IBOutlet weak var tfCertification: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var lblDownTime: CountDownTimeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = params["userID"] as? String {
            tfID.text = userID
        }

//        initLang()
    }
    
    private func initLang() {
//        lblPwd.text = getLangString("pwd_reset_title")
//        lblPwdDesc.text = getLangString("pwd_reset_desc1")
//        lblBackToFirst.text = getLangString("pwd_reset_desc2")
//        tfEmail.placeholder = getLangString("signup_email_hint")
//        btnReset.setTitle(getLangString("pwd_reset"), for: .normal)
//        btnLogin.setUnderlineTitle(getLangString("guide_btn_login"), font: AppFont.robotoRegular(11), color: AppColor.black, for: .normal)
    }
    
    override func hideKeyboard() {
        tfID.resignFirstResponder()
        tfPhonenumber.resignFirstResponder()
        tfCertification.resignFirstResponder()
    }
    
    
    private func showNonRegisterPhone() {
        AlertDialog.show(self, title: "no_phone_title"._localized, message: "no_phone_desc"._localized)
    }
    
    private func onResetSuccess(userID: String, phone: String, code: String) {
        self.pushVC(PwdChangeVC(nibName: "vc_pwd_change", bundle: nil), animated: true, params: ["userID":userID, "phone": phone, "code": code])
    }
    
    //
    // MARK: - Action
    //
    
    @IBAction func onFindPwd(_ sender: Any) {
        hideKeyboard()
        
        guard let textID = tfID.text, !textID.isEmpty else {
            self.view.showToast("Please input your ID!")
            return
        }
        
        findPwd()
    }
    
    @IBAction func onAuthReqest(_ sender: Any) {
        guard let phoneNumber = tfPhonenumber.text, !phoneNumber.isEmpty else {
            self.view.showToast("empty_phone_toast"._localized)
            return
        }
        
        authRequest(phoneNumber: phoneNumber)
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
        findPwd()
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
    func authRequest(phoneNumber: String) {
        SVProgressHUD.show()
        Rest.send_code(phoneNumber: phoneNumber, success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()
            self?.lblDownTime.startCountDownTimer()
        }) { [weak self](code, err) -> Void in
            SVProgressHUD.dismiss()
            if code == 202 {
                self?.showNonRegisterPhone()
            } else {
                self?.view.showToast(err)
            }
        }
    }
    
    func findPwd() {
        guard let loginID = tfID.text, !loginID.isEmpty else {
            self.view.showToast("empty_id_toast"._localized)
            return
        }
        
        guard let phoneNumber = tfPhonenumber.text, !phoneNumber.isEmpty else {
            self.view.showToast("empty_phone_toast"._localized)
            return
        }
        
        guard let code = tfCertification.text, !code.isEmpty else {
            self.view.showToast("Please input your certification code")
            return
        }
        
        SVProgressHUD.show()
        Rest.findPwd(loginid: loginID, phoneNumber: phoneNumber, code: code, success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            let data = result as! ModelPhoneVerify
            self?.onResetSuccess(userID: loginID, phone: phoneNumber, code: data.code.description)
        }, failure: { (code, err) -> Void in
            SVProgressHUD.dismiss()
            if code == 202 {
                //self?.showError(err)
                return
            }
            self.view.showToast(err)
        })
    }
}
