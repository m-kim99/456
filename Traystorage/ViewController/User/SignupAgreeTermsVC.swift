import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class SignupAgreeTerms: BaseVC {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
        
    @IBOutlet weak var imageViewAllAgree: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    
    open var authType = AuthType.phone
    open var authMedia = ""
    open var authCode = ""
    
    var isAllAgree = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAllAgreeImage()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
    }
    
    private func updateAllAgreeImage() {
        let imageName = isAllAgree ? "Icon-C-CheckOn-24" : "Icon-C-CheckOff-24"
        self.imageViewAllAgree.image = UIImage(named: imageName)
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
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
                let user = ret as! ModelUser
                user.pwd = pwd
                Local.setUser(user)
                Rest.user = user
                self?.goNext()
            } else {
                self?.view.showToast(ret.msg)
            }
            
        }, failure: { (_, err) -> Void in
            SVProgressHUD.dismiss()
            self.view.showToast(err)
        })
    }
}

//
// MARK: - Action
//
extension SignupAgreeTerms: BaseAction {
    @IBAction func onBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickAllAgree(_ sender: Any) {
        isAllAgree = !isAllAgree
        updateAllAgreeImage()
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
}

//
// MARK: - Navigation
//
extension SignupAgreeTerms: BaseNavigation {
    private func goNext() {
        let vc = SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil)
    //        vc.authType = authType
    //        vc.authMedia = authMedia
    //        vc.authCode = authCode
    //        vc.authPwd = tfPwd.text!
        self.pushVC(vc, animated: true)
    }
}
