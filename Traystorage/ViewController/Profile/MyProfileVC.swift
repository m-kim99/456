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
    }
    

    
    func loadUser() {
//        SVProgressHUD.show()
//        Rest.otherUserInfo(user_uid: userUid, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            self.setUserInfo(result as! ModelUser)
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
    }
    
    private func hideKeyboard() {
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
    
    
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onChangeAvatar(_ sender: Any) {
        
    }
    
    @IBAction func onEditName(_ sender: Any) {
        updateEditState(true)
        editName.becomeFirstResponder()
    }
    @IBAction func onSave(_ sender: Any) {
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onEditNameDidEnd(_ sender: Any) {
        updateEditState(false)
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
