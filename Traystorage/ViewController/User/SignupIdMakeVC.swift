import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class SignupIdMakeVC: BaseVC {

    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblDesc: UIFontLabel!
    
    @IBOutlet weak var tfId: UIFontTextField!
    @IBOutlet weak var lblError: UIFontLabel!
    
    @IBOutlet weak var btnNext: UIFontButton!
    
    @IBOutlet weak var lblMember: UIFontLabel!
    @IBOutlet weak var btnLogin: UIFontButton!
    
    @IBOutlet weak var lblAccount: UIFontLabel!
    @IBOutlet weak var lblRoadman: UIFontLabel!
    @IBOutlet weak var lblAnd: UIFontLabel!
    @IBOutlet weak var lblAsFollow: UIFontLabel!
    @IBOutlet weak var btnPrivacy: UIFontButton!
    @IBOutlet weak var btnUseAgre: UIFontButton!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    open var authCode = ""
    open var authPwd = ""
    open var authName = ""
    open var authBithday = ""
    open var authGender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLang()
        initVC()
    }
    
    private func initLang() {
        lblTitle.text = getLangString("signup_id_make")
        lblDesc.text = getLangString("signup_id_make_desc")
        
        tfId.placeholder = getLangString("signup_id_hint")
        
        btnNext.setTitle(getLangString("signup_next"), for: .normal)
        
        lblMember.text = getLangString("signup_member_1")
        btnLogin.setUnderlineTitle(getLangString("guide_btn_login"), font: AppFont.robotoRegular(11), color: AppColor.black, for: .normal)
        
        lblAccount.text = getLangString("signup_id_account")
        lblRoadman.text = getLangString("signup_id_roadman")
        lblAnd.text = getLangString("signup_id_and")
        lblAsFollow.text = getLangString("signup_id_as_follow")
        
        btnPrivacy.setUnderlineTitle(getLangString("signup_id_privacy"),
                                     font: AppFont.robotoRegular(10.5),
                                     color: AppColor.dark,
                                     for: .normal)
        
        btnUseAgre.setUnderlineTitle(getLangString("signup_id_service_agree"),
                                     font: AppFont.robotoRegular(10.5),
                                     color: AppColor.dark,
                                     for: .normal)
    }
    
    private func initVC() {
        tfId.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tfId.delegate = self
        
        hideError()
        enableNext(false)
    }
    
    private func enableNext(_ enable: Bool) {
        btnNext.isEnabled = enable
        btnNext.backgroundColor = enable ? AppColor.black : AppColor.gray
    }
    
    private func showError(_ msg: String) {
        tfId.borderColor = AppColor.error
        lblError.isHidden = false
        lblError.text = msg
    }
    
    private func hideError() {
        tfId.borderColor = AppColor.gray
        lblError.isHidden = true
    }
    
    private func hideKeyboard() {
        tfId.resignFirstResponder()
    }
    
    private func isValidInput() {
        var isValid = true
        if isValid && tfId.text!.isEmpty {
            isValid = false
        }
        
        if isValid && !ModelUser.isIdValid(tfId.text!) {
            isValid = false
            showError(getLangString("signup_id_error_valid"))
        }
        
        if isValid {
            hideError()
        }
        
        enableNext(isValid)
    }
}

//
// MARK: - Action
//
extension SignupIdMakeVC: BaseAction {
    @IBAction func onBack(_ sender: Any) {
        hideKeyboard()
        popVC()
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        hideKeyboard()
        signup()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
    
    @IBAction func onPrivacy(_ sender: Any) {
        let vc = WebViewVC(nibName: "vc_webview", bundle: nil)
        vc.strTitle = getLangString("web_privacy")
        vc.strUrl = ""
        self.pushVC(vc, animated: true)
    }
    
    @IBAction func onUseAgre(_ sender: Any) {
        let vc = WebViewVC(nibName: "vc_webview", bundle: nil)
        vc.strTitle = getLangString("web_use_agree")
        vc.strUrl = ""
        self.pushVC(vc, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        isValidInput()
    }
}

//
// MARK: - Navigation
//
extension SignupIdMakeVC: BaseNavigation {
    private func goNext() {
        self.pushVC(SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil), animated: true)
    }
}

//
// MARK: - UITextFieldDelegate
//
extension SignupIdMakeVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isValidInput()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        if textField == tfId, newLength > 16 {
            return false
        }
        
        return true
    }
}

//
// MARK: - RestApi
//
extension SignupIdMakeVC: BaseRestApi {
    func signup() {
        SVProgressHUD.show()
        Rest.signup(email: authType == AuthType.email ? authMedia : "",
                    phone: authType == AuthType.phone ? authMedia : "",
                    pwd: authPwd,
                    name: authName,
                    id: tfId.text!,
                    birthday: authBithday,
                    gender: authGender,
                    certKey: authCode,
                    success: { (result) in
                        SVProgressHUD.dismiss()
                        if result!.result == 0 {
                            Rest.user = (result as! ModelUser)
                            Rest.user.pwd = self.authPwd
                            Local.setUser(Rest.user)
                            self.goNext()
                        } else {
                            self.view.showToast(result!.msg)
                        }
                    }, failure: { (_, msg) in
                        SVProgressHUD.dismiss()
                        self.view.showToast(msg)
                    })
    }
}
