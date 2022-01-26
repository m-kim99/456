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
    
    @IBAction func onLogin(_ sender: Any) {
        hideKeyboard()
        login()
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
                    login()
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
}

//
// MARK: - RestApi
//
extension LoginVC: BaseRestApi {
    func login() {
        SVProgressHUD.show()
        guard let userID = tfId.text?.trimmingCharacters(in: .whitespacesAndNewlines), !userID.isEmpty else {
            return
        }
        
        guard let password = tfPwd.text, !password.isEmpty else {
            return
        }
        
        Rest.login(id: userID, pwd: password, success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            let code = result!.result
            
            if code == 0 {
                Rest.user = (result as! ModelUser)
                Rest.user.pwd = password
                Local.setUser(Rest.user)
                
                if let weakSelf = self {
                    let ud = UserDefaults.standard
                    ud.set(weakSelf.isAutoLogin, forKey: Local.PREFS_APP_AUTO_LOGIN.rawValue)
                    ud.synchronize()
                    weakSelf.openMainVC()
                }
            } else {
                if code == 211 { // wrong pass
                    self?.loginAttempCount += 1
                }

                self?.view.showToast(result!.msg)
                
                if let attempCount = self?.loginAttempCount, attempCount > 5, let vc = self {
                    AlertDialog.show(vc, title: "login_suspend_title"._localized,
                                     message: "login_suspend_desc"._localized)
                    self?.btnLogin.isEnabled = false
                }
            }
        }, failure: { (_, err) -> Void in
            SVProgressHUD.dismiss()
            self.view.showToast(err)
        })
        
//        self.openMainVC()
    }
}
