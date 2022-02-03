import SVProgressHUD
import UIKit
import Photos
import ActionSheetController

class MyProfileVC: BaseVC {

    @IBOutlet weak var vwAvatar: UIImageView!
    @IBOutlet weak var btnAddAvatar: UIButton!
    @IBOutlet weak var vwNameLabelGroup: UIStackView!
    @IBOutlet weak var labelName: UILabel!

    @IBOutlet weak var editName: UITextField!

    @IBOutlet weak var birthdayEdit: UITextField!
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var gender: Int = 0
    var avatarImage: UIImage?
    var avatarImageURL: String?
    var avatarImageName: String? // used to send "api"
    
    
    var isModified = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        updateGender()
    }
    
    
    func initVC() {
        let user = Rest.user!
        avatarImageURL = user.profile_img
        if let avatarUrl = URL(string:avatarImageURL ?? "") {
            avatarImageName = avatarUrl.lastPathComponent
            vwAvatar.kf.setImage(with: avatarUrl, placeholder: UIImage(named: "Icon-C-User-60")!)
        }

        labelName.text = user.name
        editName.text = labelName.text
        editName.text = user.name
        birthdayEdit.text = user.birthday.replaceAll("-", with: ".")
        emailEdit.text = user.email

        gender = user.gender
        updateGender()
        
        NotificationCenter.default.addObserver(self, selector: #selector(imgPick(_:)), name: NSNotification.Name(rawValue: "image_pick"), object: nil)
    }
    
    override func hideKeyboard() {
        editName.resignFirstResponder()
        birthdayEdit.resignFirstResponder()
        emailEdit.resignFirstResponder()
    }
    
    private func updateEditState(_ isNameEditing: Bool) {
        btnAddAvatar.isHidden = !isNameEditing
        
        vwNameLabelGroup.isHidden = isNameEditing
        editName.isHidden = !isNameEditing
        labelName.isHidden = isNameEditing

        birthdayEdit.isEnabled = isNameEditing
        birthdayButton.isEnabled = isNameEditing
        emailEdit.isEnabled = isNameEditing
        maleButton.isEnabled = isNameEditing
        femaleButton.isEnabled = isNameEditing
        saveButton.isEnabled = isNameEditing
    }
    
    private func updateGender() {
        let maleColor = gender == 0 ? AppColor.active : AppColor.gray
        let femaleColor = gender == 1 ? AppColor.active : AppColor.gray
        
        maleButton.borderColor = maleColor
        maleButton.tintColor = maleColor
        femaleButton.borderColor = femaleColor
        femaleButton.tintColor = femaleColor
    }
    
    @objc func imgPick(_ notification : Notification) {
        let imgList = notification.object as! [UIImage]
        let image = imgList[0]
        avatarImage = image
        vwAvatar.image = image
        isModified = true
    }
    
    private func onUploadedAvatar(url: String, name: String) {
        avatarImageURL = url
        avatarImage = nil
        avatarImageName = name
        
        onSave("")
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        if !isModified {
            super.onBackProcess(viewController)
            return
        }
        ConfirmDialog.show(self, title: "profile_discard_title"._localized, message: "profile_discard_desc"._localized, showCancelBtn: true) { [weak self] () -> Void in
            self?.popVC()
        }
    }
    
    @IBAction func onChangeAvatar(_ sender: Any) {
        let vc = GalleryViewController(nibName: "vc_gallery", bundle: nil)
        vc.multi = 0
        self.pushVC(vc, animated: true)
    }
    
    @IBAction func onEditName(_ sender: Any) {
        updateEditState(true)
        editName.becomeFirstResponder()
    }
    
    @IBAction func onSave(_ sender: Any) {
        guard let name = editName.text, !name.isEmpty else {
            self.view.showToast("empty_name_toast"._localized)
            return
        }
        
        guard let email = emailEdit.text, !email.isEmpty, Validations.email(email) else {
            self.view.showToast("invalid_email_toast"._localized)
            return
        }
        
        if let image = avatarImage {
            uploadProfileImage(image: image)
            return
        }
        
        updateProfile(name: name, birthDay: self.birthdayEdit.text ?? "", email: email, gender: gender, profileImage:avatarImageName ?? "")
    }
    
    @IBAction func onEditNameDidEnd(_ sender: UITextField!) {
//        updateEditState(false)
//        labelName.text = sender.text
        isModified = true
    }
    
    
    @IBAction func onClickGender(_ sender: Any) {
        if let button = sender as? UIButton {
            gender = button == maleButton ? 0 : 1
            updateGender()
            isModified = true
        }
    }
    
    @IBAction func onClickBirthDay(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let birthday = dateFormatter.date(from: birthdayEdit.text ?? "")
        DatepickerDialog.show(self, date:birthday) { [weak self](date) in
            self?.birthdayEdit.text = dateFormatter.string(from: date)
            self?.isModified = true
        }
    }
}

extension MyProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == editName, newLen > 20 {
            return false
        }
        
        if textField == emailEdit, newLen > 30 {
            return false
        }
        
        if textField == emailEdit {
            isModified = true
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == editName {
            editName.resignFirstResponder()
        }
        
        return true
    }
}

//
// MARK: - RestApi
//
extension MyProfileVC: BaseRestApi {
    func updateProfile(name: String, birthDay:String, email: String, gender: Int, profileImage: String) {
        SVProgressHUD.show()
        
        let dbDirthDay = birthDay.replaceAll(".", with: "-")
        Rest.makeProfile(name: name, birthday: dbDirthDay, gender: gender, email: email, profileImage:profileImage, success: { [weak self, gender] (result) -> Void in
            SVProgressHUD.dismiss()
            
            let user = Rest.user!
            let pwd = user.pwd;
            
            Rest.user = (result as! ModelUser)
            Rest.user.pwd = pwd
            Rest.user.gender = gender
            Local.setUser(Rest.user)
            
            self?.isModified = false
//            self?.showToast("profile_changed"._localized)
            self?.popVC()
        }) { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
    
    func uploadProfileImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        SVProgressHUD.show()
        
        Rest.uploadFiles(files: [imageData], success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            
            let retFileName = result as! ModelUploadFileList
            
            let fileName = retFileName.fileNames[0]
            let fileUrl = retFileName.fileUrls[0]
            self?.onUploadedAvatar(url: fileUrl, name: fileName)
        }) { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
}
