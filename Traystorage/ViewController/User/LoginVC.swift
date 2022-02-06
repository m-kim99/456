import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class LoginVC: BaseVC {
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
//    @IBOutlet weak var btnShowPwd: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var autoLoginCheckImage: UIImageView!
    
    var isAutoLogin = true
    var loginAttempCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAutoLoginUI()

//        enableLogin(false)
    }
    
    private func updateAutoLoginUI() {
        let autoLoginCheckImage = isAutoLogin ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        self.autoLoginCheckImage.image = UIImage(named: autoLoginCheckImage)
    }
    
    func resetLoginInputInformation() {
        tfId.text = nil
        tfPwd.text = nil
        loginAttempCount = 0
        btnLogin.isEnabled = true
    }
    
    func setLoginID(userID: String) {
        tfId.text = userID
    }
    
    override func hideKeyboard() {
        tfId.resignFirstResponder()
        tfPwd.resignFirstResponder()
    }
    
    private func onLoginSuccess(user: ModelUser!, password: String) {
        Rest.user = user
        Rest.user.pwd = password
        Local.setUser(Rest.user)

        let ud = UserDefaults.standard
        ud.set(isAutoLogin, forKey: Local.PREFS_APP_AUTO_LOGIN.rawValue)
        ud.synchronize()
        openAgreeView()
    }
    
    private func showInvalidAccount() {
        AlertDialog.show(self, title: "login_faided_invalid_account"._localized,
                         message: "")
    }
    
    private func onRecvWrongPassword() {
        loginAttempCount += 1
        if loginAttempCount > 5 {
            onAccountPaused()
            btnLogin.isEnabled = false
        } else {
            showInvalidAccount()
        }
    }
    
    private func onAccountPaused() {
        AlertDialog.show(self, title: "login_suspend_title"._localized,
                         message: "login_suspend_desc"._localized) {
            [weak self] in
            self?.popToStartVC()
        }
    }
    
    private func onWithDrawUserExist(_ loginId: String) {
        showConfirm(title: "login_withdrawal_title"._localized,
                    message: "login_withdrawal_desc"._localized, showCancelBtn: true) {
            [weak self] in
            let vc = FindIdVC(nibName: "vc_find_id", bundle: nil)
            vc.findIDRequest = .withDrawalCancel
            vc.loginId = loginId
            self?.pushVC(vc, animated: true)
        }
    }
    
    @IBAction func onClickAutoLogin(_ sender: Any) {
        isAutoLogin = !isAutoLogin
        updateAutoLoginUI()
    }
}

//
// MARK: - Action
//
extension LoginVC: BaseAction {
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        hideKeyboard()
        
        guard let userID = tfId.text?.trimmingCharacters(in: .whitespacesAndNewlines), !userID.isEmpty else {
            self.view.showToast("empty_id_toast"._localized)
            return
        }
        
        guard let password = tfPwd.text, !password.isEmpty else {
            self.view.showToast("empty_password_toast"._localized)
            return
        }
        
        login(userID: userID, password: password)
    }
    
    @IBAction func onClickShowPwd(_ sender: Any) {
//        btnShowPwd.isSelected = !btnShowPwd.isSelected
//        tfPwd.isSecureTextEntry = !btnShowPwd.isSelected
    }
    
    @IBAction func onFindPassword(_ sender: Any) {
       self.pushVC(FindPwdVC(nibName: "vc_findpwd", bundle: nil), animated: true)
    }
    
    @IBAction func onFindID(_ sender: Any) {
        self.pushVC(FindIdVC(nibName: "vc_find_id", bundle: nil), animated: true)
    }
}

//
// MARK: - UITextFieldDelegate
//
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case tfId:
                tfPwd.becomeFirstResponder()
                break
            case tfPwd:
                if btnLogin.isEnabled {
                
                    onClickLogin("")
                }
                textField.resignFirstResponder()
                break
            default:
                textField.resignFirstResponder()
                break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfId, newLen > 20 {
            return false
        }
        if textField == tfPwd, newLen > 12 {
            return false
        }

        return true
    }
}


// MARK: - RestApi
//
extension LoginVC: BaseNavigation {
    func openMainVC() {
        let mainVC = UIStoryboard(name: "vc_main", bundle: nil).instantiateInitialViewController()
//        self.replaceVC(MainVC(nibName: "vc_main", bundle: nil), animated: true)
        self.pushVC(mainVC as! BaseVC, animated: true)
    }
    
    
    func openAgreeView() {
        if Rest.user.isAgree == 0 {
            pushVC(LoginAgreeTermsVC(nibName: "vc_login_agree_terms", bundle: nil), animated: true)
        } else {
            openMainVC()
        }
    }
}

//
// MARK: - RestApi
//
extension LoginVC: BaseRestApi {
    func login(userID: String, password: String) {
        LoadingDialog.show()
        Rest.login(id: userID, pwd: password, success: { [weak self] (result) -> Void in
            LoadingDialog.dismiss()
            self?.onLoginSuccess(user: result! as? ModelUser, password: password)
        }) { [weak self](code, err) -> Void in
            LoadingDialog.dismiss()
            let resultCode = ResponseResultCode(rawValue: code) ?? .ERROR_SERVER
            switch resultCode {
            case .ERROR_WRONG_PWD:
                self?.onRecvWrongPassword()
                break
            case .ERROR_USER_NO_EXIST:
                self?.showInvalidAccount()
                break
            case .ERROR_USER_EXIT:
                self?.onWithDrawUserExist(userID)
                break
            case .ERROR_USER_PAUSED:
                self?.onAccountPaused()
                break
            default:
                self?.view.showToast(err)
                break
            }
        }
    }
}
