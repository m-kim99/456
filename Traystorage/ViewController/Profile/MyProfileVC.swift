import SVProgressHUD
import UIKit
import Photos
import ActionSheetController

class MyProfileVC: BaseVC {

    @IBOutlet weak var vwAvatar: UIImageView!
    @IBOutlet weak var vwNameLabelGroup: UIStackView!
    @IBOutlet weak var labelName: UILabel!

    @IBOutlet weak var editName: UITextField!

    @IBOutlet weak var birthdayEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var isUserMale = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        
        updateGender()
    }
    
    
    func initVC() {
        let user = Local.getUser()
        if let url = user.profile_img {
            vwAvatar.kf.setImage(with: URL(string: url))
        }

        labelName.text = user.name
        editName.text = user.name
        birthdayEdit.text = user.birthday
        
        emailEdit.text = user.email
        
        isUserMale = user.gender ?? "0" == "0"
    }
    
    func loadUser() {
        SVProgressHUD.show()
        let user = Local.getUser()
        guard let uid = user.uid else {
            return
        }
        Rest.otherUserInfo(user_uid: uid, success: { (result) -> Void in
            SVProgressHUD.dismiss()
//            self.setUserInfo(result as! ModelUser)
        }, failure: { (_, err) -> Void in
            SVProgressHUD.dismiss()
            self.view.showToast(err)
        })
    }
    
    override func hideKeyboard() {
        editName.resignFirstResponder()
        birthdayEdit.resignFirstResponder()
        emailEdit.resignFirstResponder()
    }
    
    private func updateEditState(_ isNameEditing: Bool) {
        vwNameLabelGroup.isHidden = isNameEditing
        editName.isHidden = !isNameEditing
    }
    
    private func updateGender() {
        let maleColor = isUserMale ? AppColor.active : AppColor.gray
        let femaleColor = !isUserMale ? AppColor.active : AppColor.gray
        
        maleButton.borderColor = maleColor
        maleButton.tintColor = maleColor
        femaleButton.borderColor = femaleColor
        femaleButton.tintColor = femaleColor
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "Edits are not saved when moving to the previous screen", message: "Do you want to go to the previous screen?", showCancelBtn: true) { [weak self] () -> Void in
            self?.popVC()
        }
    }
    
    @IBAction func onChangeAvatar(_ sender: Any) {
        
    }
    
    @IBAction func onEditName(_ sender: Any) {
        updateEditState(true)
        editName.becomeFirstResponder()
    }
    @IBAction func onSave(_ sender: Any) {
        guard let name = labelName.text, !name.isEmpty else {
            self.view.showToast("Your name is invalid")
            return
        }
        
        guard let email = emailEdit.text, !email.isEmpty else {
            self.view.showToast("Your email is invalid")
            return
        }
        
        self.view.showToast("Your profile was changed")
        popVC()
    }
    
    @IBAction func onEditNameDidEnd(_ sender: UITextField!) {
        updateEditState(false)
        labelName.text = sender.text
    }
    
    
    @IBAction func onClickGender(_ sender: Any) {
        if let button = sender as? UIButton {
            isUserMale = button == maleButton
            updateGender()
        }
    }
    
    @IBAction func onClickBirthDay(_ sender: Any) {
        DatepickerDialog.show(self) { [weak self](date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self?.birthdayEdit.text = dateFormatter.string(from: date)
        }
    }
}

extension MyProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == editName, newLen > 20 {
            return false
        }

        return true
    }
}
