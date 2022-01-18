import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class LoginVC: BaseVC {
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
//    @IBOutlet weak var btnShowPwd: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
//    @IBOutlet weak var btnPrivacy: UIFontButton!
//    @IBOutlet weak var btnUseAgre: UIFontButton!
    
    @IBOutlet weak var lblLogin: UIFontLabel!
    @IBOutlet weak var lblRoadman: UIFontLabel!
    @IBOutlet weak var lblOr: UIFontLabel!
    @IBOutlet weak var lblYouCan: UIFontLabel!
    
    @IBOutlet weak var autoLoginCheckImage: UIImageView!
    
    var isAutoLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        autoLoginCheckImage.image
        
//        initLang()
//        initVC()
    }
    
//    private func initLang() {
//        tfId.placeholder = getLangString("login_id_hint")
//        tfPwd.placeholder = getLangString("login_pwd_hint")
//        
//        btnLogin.setTitle(getLangString("login_btn"), for: .normal)
//        btnFindPwd.setTitle(getLangString("login_pwd_forgets"), for: .normal)
//        
//        lblLogin.text = getLangString("login_agree_1")
//        lblRoadman.text = getLangString("login_agree_2")
//        lblOr.text = getLangString("login_agree_4")
//        lblYouCan.text = getLangString("login_agree_6")
//        
//    }
//    
    private func initVC() {
        enableLogin(false)
    }
    
    private func enableLogin(_ enable: Bool) {
        btnLogin.isEnabled = enable
//        btnLogin.backgroundColor = enable ? AppColor.black : AppColor.gray
    }
    
    private func isValidInput() {
        var isValid = true
        if isValid && tfId.text!.isEmpty {
            isValid = false
        }
        
        if isValid && tfPwd.text!.isEmpty {
            isValid = false
        }
        
        if isValid && tfPwd.text!.count < 8 {
            isValid = false
        }
        
        enableLogin(isValid)
    }
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickAutoLogin(_ sender: Any) {
        
        isAutoLogin = !isAutoLogin
        
        let autoLoginCheckImage = isAutoLogin ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        
        self.autoLoginCheckImage.image = UIImage(named: autoLoginCheckImage)
    }
}

//
// MARK: - Action
//
extension LoginVC: BaseAction {
    @IBAction func onClickBg(_ sender: Any) {
        tfId.resignFirstResponder()
        tfPwd.resignFirstResponder()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        onClickBg(sender)
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
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
//        isValidInput()
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
}


// MARK: - RestApi
//
extension LoginVC: BaseNavigation {
    func openMainVC() {
        
        let mainVC = UIStoryboard(name: "vc_main", bundle: nil).instantiateInitialViewController()
//        self.replaceVC(MainVC(nibName: "vc_main", bundle: nil), animated: true)
        self.replaceVC(mainVC as! BaseVC, animated: true)
    }
}

//
// MARK: - RestApi
//
extension LoginVC: BaseRestApi {
    func login() {
//        SVProgressHUD.show()
//        Rest.login(id: tfId.text, pwd: tfPwd.text, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            if result!.result == 0 {
//                Rest.user = (result as! ModelUser)
//                Local.setUser(Rest.user)
//                self.openMainVC()
//            } else {
//                self.view.showToast(result!.msg)
//            }
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
        
        ConfirmDialog.show(self, title: "Your account has been permanently suspended by",
                           message: "Your account has been permanetly suspended for posting inappropriate", showCancelBtn: true) { [weak self]() -> Void in
            
            self?.openMainVC()
        }
    }
}
