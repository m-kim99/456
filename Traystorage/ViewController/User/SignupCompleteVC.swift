import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit
import Photos
import ActionSheetController

class SignupCompleteVC: BaseVC {
    @IBOutlet weak var tfBirthday: UITextField!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    var userGender = 0
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGender()
        
        initLang()
//        initVC()
    }
    
    private func initLang() {
//        lblWelcome.text = String.init(format: "%@%@", Local.getUser().name!, getLangString("signup_welcome"))
//        lblDesc.text = getLangString("signup_complete_desc")
//        btnStart.setTitle(getLangString("signup_do_start"), for: .normal)
    }
    
    private func initVC() {
    }
    
    private func authorize(_ status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(), fromViewController: UIViewController, completion: @escaping (_ authorized: Bool) -> Void) {
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.authorize(status, fromViewController: fromViewController, completion: completion)
                })
            })
        default:
            DispatchQueue.main.async(execute: { () -> Void in
                completion(false)
            })
        }
    }
    
    
    private func updateGender() {
        let maleColor = userGender == 0 ? AppColor.active : AppColor.gray
        let femaleColor = userGender == 1 ? AppColor.active : AppColor.gray
        
        maleButton.borderColor = maleColor
        maleButton.tintColor = maleColor
        femaleButton.borderColor = femaleColor
        femaleButton.tintColor = femaleColor
    }
    
    private func openMainVC() {
        let mainVC = UIStoryboard(name: "vc_main", bundle: nil).instantiateInitialViewController()
        self.pushVC(mainVC! as! BaseVC, animated: true)
    }
    
    override func hideKeyboard() {
        tfName.resignFirstResponder()
        tfBirthday.resignFirstResponder()
        tfEmail.resignFirstResponder()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
    }
}

//
// MARK: - Action
//
extension SignupCompleteVC: BaseAction {
    @IBAction func onClickBirthday(_ sender: Any) {
        hideKeyboard()
        DatepickerDialog.show(self) { [weak self](date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self?.tfBirthday.text = dateFormatter.string(from: date)
//            self.isValidInput()
        }
    }
    
    @IBAction func onClickGender(_ sender: Any) {
        if let button = sender as? UIButton {
            userGender = button == maleButton ? 0 : 1
            updateGender()
        }
    }
    
    @IBAction func onClickDoStart(_ sender: Any) {
//        replaceVC(MainVC(nibName: "vc_main", bundle: nil), animated: true)
    }
    
    @IBAction func onClickUseService(_ sender: Any) {
        makeProfile()
    }
}

//
// MARK: - UITextFieldDelegate
//
extension SignupCompleteVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            let newLen = (textField.text?.count ?? 0) - range.length + string.count

            if textField == tfName, newLen > 20 {
                return false
            }
            
            if textField == tfEmail, newLen > 50 {
                return false
            }

            return true
        }
}

//
// MARK: - RestApi
//
extension SignupCompleteVC: BaseRestApi {
    func makeProfile() {
        guard let name = tfName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !name.isEmpty else {
            self.view.showToast("Please input your name")
            return
        }
        
        guard name.count >= 2 else {
            self.view.showToast("Please input your name with 2+ character")
            return
        }
        
        guard let email = tfEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !email.isEmpty else {
            self.view.showToast("Please input your email")
            return
        }
        
        guard Validations.email(email) else {
            self.view.showToast("Invalid email")
            return
        }
        
        let birthDay = tfBirthday.text ?? ""
        
        SVProgressHUD.show()
        Rest.makeProfile(name: name, birthday: birthDay, gender: userGender, email: email, success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
                self?.openMainVC()
            } else {
                self?.view.showToast(ret.msg)
            }
        }, failure: { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        })
    }
}
