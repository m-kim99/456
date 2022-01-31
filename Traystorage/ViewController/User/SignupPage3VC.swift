import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class SignupPage3VC: BaseVC {
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnAllAgree: UIButton!
    @IBOutlet weak var btnTermsAgree: UIButton!
    @IBOutlet weak var btnPolicyAgree: UIButton!
    
    
    @IBOutlet weak var btnTermsView: UIButton!
    @IBOutlet weak var btnPolicyView: UIButton!
    
    
    open var authType = AuthType.phone
    open var authMedia = ""
    open var authCode = ""
    
    var isTermAgree = false
    var isPrivacyAgree = false
    
    weak var nextDelegate: SignupNextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let disableCheckImage = UIImage(named: "Icon-C-Check-Gray-24 Copy")!
        btnTermsAgree.setImage(disableCheckImage, for: .disabled)
        btnPolicyAgree.setImage(disableCheckImage, for: .disabled)
        updateAgreeState()
    }
    
    private func updateAgreeState() {
        let imageName = (isTermAgree && isPrivacyAgree) ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        self.btnAllAgree.setImage(UIImage(named: imageName), for: .normal)
        btnNext.isEnabled = isTermAgree && isPrivacyAgree
        
        let checkImage = "Icon-C-Check-24"
        let disableCheckImage = "Icon-C-Check-Gray-24 Copy"
        let termImageName = isTermAgree ? checkImage : disableCheckImage
        
        let termImage = UIImage(named: termImageName)
        btnTermsAgree.setImage(termImage, for: .normal)
        
        let policyImageName = isPrivacyAgree ? checkImage : disableCheckImage
        let policyImage = UIImage(named: policyImageName)
        btnPolicyAgree.setImage(policyImage, for: .normal)
    }
    
    private func signup() {
        SVProgressHUD.show()
        print(params)
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
            self?.showToast(err)
        }
    }
}

//
// MARK: - Action
//
extension SignupPage3VC: BaseAction {
    @IBAction func onClickAllAgree(_ sender: Any) {
        let isAllAgree = isTermAgree && isPrivacyAgree
        isTermAgree = !isAllAgree
        isPrivacyAgree = !isAllAgree
        updateAgreeState()
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        let isAllAgree = isTermAgree && isPrivacyAgree
        
        if isAllAgree {
            showConfirm(title: "signup_agree_confrim_title".localized, message: "", showCancelBtn: true) { [weak self]() -> Void in
                self?.signup()
            }
        }
        else {
            showAlert(title: "signup_agree_alert_title"._localized)
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
        let vc = TermsVC(nibName: "vc_terms", bundle: nil)
        vc.pageType = .term
        self.pushVC(vc, animated: true)
    }
    
    @IBAction func onClickPrivacyView(_ sender: Any) {
        let vc = TermsVC(nibName: "vc_terms", bundle: nil)
        vc.pageType = .privacy
        self.pushVC(vc, animated: true)
    }
}

//
// MARK: - Navigation
//
extension SignupPage3VC: BaseNavigation {
    private func goNext() {
        if let nextDelegate = self.nextDelegate {
            nextDelegate.onClickNext(step: .complete, params: [:])
        }
    }
}
