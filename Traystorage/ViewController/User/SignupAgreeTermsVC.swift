import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class LoginAgreeTerms: BaseVC {
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnAllAgree: UIButton!
    @IBOutlet weak var btnTermsAgree: UIButton!
    @IBOutlet weak var btnPolicyAgree: UIButton!
    
    
    @IBOutlet weak var btnTermsView: UIButton!
    @IBOutlet weak var btnPolicyView: UIButton!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    open var authCode = ""
    
    var isAllAgree = false
    
    var isTermAgree = true
    var isPrivacyAgree = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let disableCheckImage = UIImage(named: "Icon-C-Check-Gray-24 Copy")!
        btnTermsAgree.setImage(disableCheckImage, for: .disabled)
        btnPolicyAgree.setImage(disableCheckImage, for: .disabled)
        updateAgreeState()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToStartVC()
        }
    }
    
    private func updateAgreeState() {
        let imageName = isAllAgree ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        self.btnAllAgree.setImage(UIImage(named: imageName), for: .normal)
        btnNext.isEnabled = isAllAgree
        btnTermsAgree.isEnabled = isAllAgree
        btnPolicyAgree.isEnabled = isAllAgree
        
        let checkImage = "Icon-C-Check-24"
        let disableCheckImage = "Icon-C-Check-Gray-24 Copy"
        let termImageName = isTermAgree ? checkImage : disableCheckImage
        
        let termImage = UIImage(named: termImageName)
        btnTermsAgree.setImage(termImage, for: .normal)
        btnTermsView.isEnabled = isAllAgree && isTermAgree
        
        let policyImageName = isPrivacyAgree ? checkImage : disableCheckImage
        let policyImage = UIImage(named: policyImageName)
        btnPolicyAgree.setImage(policyImage, for: .normal)
        btnPolicyView.isEnabled = isAllAgree && isPrivacyAgree
        
        btnTermsAgree.setTitle("terms_of_use_required"._localized, for: .normal)
        btnPolicyAgree.setTitle("privacy_policy_required"._localized, for: .normal)
    }
    
    private func signup() {
        SVProgressHUD.show()
        let loginID = params["id"] as! String
        let pwd = params["pwd"] as! String
        let phone = params["phone"] as! String
        let code = params["code"] as! String
        
        Rest.signup(login_id:loginID, pwd: pwd, phone: phone, code: code, success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()
            let user = result as! ModelUser
            user.pwd = pwd
            Local.setUser(user)
            Rest.user = user
            self?.goNext()
        }) {[weak self] (_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
}

//
// MARK: - Action
//
extension LoginAgreeTerms: BaseAction {
    @IBAction func onClickAllAgree(_ sender: Any) {
        isAllAgree = !isAllAgree
        updateAgreeState()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if isAllAgree {
            ConfirmDialog.show(self, title: "signup_agree_confrim_title".localized, message: "", showCancelBtn: true) { [weak self]() -> Void in
                self?.signup()
            }
        }
        else {
            AlertDialog.show(self, title: "signup_agree_alert_title"._localized, message: "")
        }
    }
    
    @IBAction func onClickTerms(_ sender: Any) {
        isTermAgree = !isTermAgree
        updateAgreeState()
    }
    
    @IBAction func onClickPrivacy(_ sender: Any) {
        isPrivacyAgree = !isPrivacyAgree
        updateAgreeState()
    }
    
    
    @IBAction func onClickTermsView(_ sender: Any) {
        self.pushVC(TermsVC(nibName: "vc_terms", bundle: nil), animated: true, params: ["title": "terms_of_use"._localized])
    }
    
    @IBAction func onClickPrivacyView(_ sender: Any) {
        self.pushVC(TermsVC(nibName: "vc_terms", bundle: nil), animated: true, params: ["title": "privacy_policy"._localized])
    }
}

//
// MARK: - Navigation
//
extension LoginAgreeTerms: BaseNavigation {
    private func goNext() {
        let vc = SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil)
    //        vc.authType = authType
    //        vc.authMedia = authMedia
    //        vc.authCode = authCode
    //        vc.authPwd = tfPwd.text!
        self.pushVC(vc, animated: true)
    }
}
