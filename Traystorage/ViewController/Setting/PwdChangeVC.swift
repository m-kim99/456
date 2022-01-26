import SVProgressHUD
import UIKit

class PwdChangeVC: BaseVC {
    @IBOutlet weak var lblNewPwd: UILabel!
    @IBOutlet weak var tfNewPwd: UITextField!
    @IBOutlet weak var lblConfirmPwd: UILabel!
    @IBOutlet weak var tfConfirmPwd: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lineCurrent: UIView!
    @IBOutlet weak var lineNew: UIView!
    @IBOutlet weak var lineConfirm: UIView!
    @IBOutlet weak var lblCurError: UILabel!
    @IBOutlet weak var lblNewError: UILabel!
    @IBOutlet weak var lblConfirmError: UILabel!
    
    var user: ModelUser!
    
//    private lazy var user: ModelUser = {
//        return Rest.user
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initLang()
    }
    
//    private func initLang() {
//        lblPageTitle.text = getLangString("setting_pwd_change_title")
//        lblDesc1.text = getLangString("setting_pwd_change_desc1")
//        lblDesc2.text = getLangString("setting_pwd_change_desc2")
//        lblCurrentPwd.text = getLangString("setting_cur_pwd")
//        lblNewPwd.text = getLangString("setting_new_pwd")
//        lblConfirmPwd.text = getLangString("setting_new_pwd_confirm")
//        btnConfirm.setTitle(getLangString("setting_confirm"), for: .normal)
//    }
    
    override func hideKeyboard() {
        tfNewPwd.resignFirstResponder()
        tfConfirmPwd.resignFirstResponder()
    }
    
    private func onPasswordChanged() {
        ConfirmDialog.show2(self, title: "pwd_change_notify_title"._localized,
                            message: "pwd_change_notify_login"._localized,
                            showCancelBtn: false) {[weak self] in
            self?.popToLogVC()
        }
    }
    
    //
    // MARK: Action
    //
    
    @IBAction func onClickConfirm(_ sender: Any) {
        hideKeyboard()
        guard let pass = tfNewPwd.text, let confirmPass = tfConfirmPwd.text, pass == confirmPass else {
            self.view.showToast("password_mismatch_confirm"._localized)
            return
        }
        
        let loginID = params["userID"] as! String
        let phone = params["phone"] as! String
        let code = params["code"] as! String
        changePwd(userID: loginID, phone: phone, code: code, pwd: pass)
    }
}

//
// MARK: - UITextFieldDelegate
//
extension PwdChangeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case tfNewPwd:
                tfConfirmPwd.becomeFirstResponder()
                break
            case tfConfirmPwd:
                if btnConfirm.isEnabled {
                    onClickConfirm(0)
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

        if newLen > 12 {
            return false
        }
//        let strText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        let strNSText: NSString = strText as NSString
//        switch textField {
//            case tfCurPwd:
//                if (strNSText.length == 0) {
//                    lblCurError.isHidden = true
//                } else {
//                    if (strNSText.isEqual(to: user.pwd)){
//                        lblCurError.isHidden = true
//                    } else {
//                        lblCurError.isHidden = false
//                    }
//                }
//                break
//            case tfNewPwd:
//                if (strNSText.length == 0) {
//                    lblNewError.isHidden = true
//                } else {
//                    if (!ModelUser.isPasswordValid(strNSText as String)){
//                        lblNewError.isHidden = false
//                    } else {
//                        lblNewError.isHidden = true
//                    }
//                }
//                break
//            case tfConfirmPwd:
//                if (strNSText.length == 0) {
//                    lblConfirmError.isHidden = true
//                } else {
//                    if (tfNewPwd.text != strNSText as String){
//                        lblConfirmError.isHidden = false
//                    } else {
//                        lblConfirmError.isHidden = true
//                    }
//                }
//                break
//            default:
//                lblCurError.isHidden = false
//                lblNewError.isHidden = false
//                lblConfirmError.isHidden = false
//                break
//        }
//
//        enableConfirm(!tfCurPwd.text!.isEmpty && !tfNewPwd.text!.isEmpty && !tfConfirmPwd.text!.isEmpty && lblCurError.isHidden && lblNewError.isHidden && lblConfirmError.isHidden)
        return true
    }
}


//
// MARK: - RestApi
//
extension PwdChangeVC: BaseRestApi {
    func changePwd(userID: String, phone:String, code: String, pwd: String) {
        SVProgressHUD.show()
        Rest.changePwd(loginID: userID, phone: phone, code: code, password: pwd, success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            self?.onPasswordChanged()
        }) { [weak self] (_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
}
