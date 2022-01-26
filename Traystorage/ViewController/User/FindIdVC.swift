import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class FindIdVC: BaseVC {
    @IBOutlet weak var tfPhonenumber: UITextField!
    @IBOutlet weak var tfCertification: UITextField!
    @IBOutlet weak var lblDownTime: CountDownTimeLabel!
    
    var countDownTimer:  Timer?
    var countDownTime: Int = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initLang()
//        initVC()
    }
    
    private func initLang() {
//        lblPwd.text = getLangString("pwd_reset_title")
//        lblPwdDesc.text = getLangString("pwd_reset_desc1")
//        lblBackToFirst.text = getLangString("pwd_reset_desc2")
//        tfEmail.placeholder = getLangString("signup_email_hint")
    }
    
    override func hideKeyboard() {
        tfPhonenumber.resignFirstResponder()
        tfCertification.resignFirstResponder()
    }
    
    private func onResetSuccess(userID: String) {
        pushVC(CheckIdVC(nibName: "vc_check_id", bundle: nil), animated: true, params: ["userID": userID])
    }
    
    private func showNonRegisterPhone() {
        AlertDialog.show(self, title: "no_phone_title"._localized, message: "no_phone_desc"._localized)
    }
    
    private func showAlert(title: String, message: String) {
        AlertDialog.show(self, title: title, message: message)
    }
    
    //
    // MARK: - Action
    //
    
    @IBAction func onClickConfirm(_ sender: Any) {
        hideKeyboard()
        resetPwd()
    }
    
    @IBAction func onClickAuthRequest(_ sender: Any) {
        hideKeyboard()
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
extension FindIdVC: UITextFieldDelegate {
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
        if textField == tfCertification, newLen > 10 {
            return false
        }

        return true
    }
}

//
// MARK: - RestApi
//
extension FindIdVC: BaseRestApi {
    func resetPwd() {
        guard let phoneNumber = tfPhonenumber.text?.trimmingCharacters(in: .whitespacesAndNewlines), !phoneNumber.isEmpty else {
            showAlert(title: "empty_phone_alert"._localized, message: "")
            return
        }
        
        guard let code = tfCertification.text?.trimmingCharacters(in: .whitespacesAndNewlines), !code.isEmpty else {
            return
        }
        
        SVProgressHUD.show()
        Rest.find_login_id(phoneNumber: phoneNumber, code: code, success: {[weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            
            let user = result as! ModelUser
            self?.onResetSuccess(userID: user.uid)
       
        }) {[weak self] (code, err) -> Void in
            SVProgressHUD.dismiss()
//            if code == 105 { // verify code is wrong
                self?.showAlert(title: err, message: "")
//            }
        }
    }
    
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
}
