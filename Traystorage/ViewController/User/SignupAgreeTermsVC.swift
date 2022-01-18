import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class SignupAgreeTerms: BaseVC {
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblDesc: UIFontLabel!
        
    @IBOutlet weak var imageViewAllAgree: UIImageView!
    @IBOutlet weak var btnNext: UIFontButton!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    open var authCode = ""
    
    var isAllAgree = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initLang()
//        initVC()
        updateAllAgreeImage()
    }
    
    private func initLang() {
//        lblTitle.text = getLangString("signup_pwd_make")
//        btnNext.setTitle(getLangString("signup_next"), for: .normal)
    }
    
    private func initVC() {
        hideError()
        enableNext(false)
    }
    
    private func enableNext(_ enable: Bool) {
        btnNext.isEnabled = enable
        btnNext.backgroundColor = enable ? AppColor.black : AppColor.gray
    }
    
    private func showError(_ msg: String, for type: String) {
        self.view.showToast(msg)
    }
    
    private func hideError() {
//        tfPwd.borderColor = AppColor.gray
//        tfPwdCon.borderColor = AppColor.gray
//        lblError.isHidden = true
    }
    
    private func hideKeyboard() {
    }
    
    private func isValidInput() {
        var isValid = true
//
//
//        if isValid && !ModelUser.isPasswordValid(tfPwd.text!) {
//            isValid = false
//            showError(getLangString("signup_pwd_error"), for: "pwd")
//        }
//
//        if isValid && tfPwd.text! != tfPwdCon.text! {
//            isValid = false
//            showError(getLangString("signup_pwd_confirm_error"), for: "pwd_confirm")
//        }
//
//        if isValid {
//            hideError()
//        }
        
        enableNext(isValid)
    }
    
    private func updateAllAgreeImage() {
        let imageName = isAllAgree ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        self.imageViewAllAgree.image = UIImage(named: imageName)
    }
}

//
// MARK: - Action
//
extension SignupAgreeTerms: BaseAction {
    @IBAction func onBack(_ sender: Any) {
        hideKeyboard()
        popVC()
    }
    
    @IBAction func onClickAllAgree(_ sender: Any) {
        isAllAgree = !isAllAgree
        updateAllAgreeImage()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        hideKeyboard()
        goNext()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
}

//
// MARK: - Navigation
//
extension SignupAgreeTerms: BaseNavigation {
    private func goNext() {
        ConfirmDialog.show(self, title: "Would you like to register as a member with the information you entered?", message: "", showCancelBtn: true) { [weak self]() -> Void in
            let vc = SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil)
    //        vc.authType = authType
    //        vc.authMedia = authMedia
    //        vc.authCode = authCode
    //        vc.authPwd = tfPwd.text!
            self?.pushVC(vc, animated: true)
        }

    }
}
