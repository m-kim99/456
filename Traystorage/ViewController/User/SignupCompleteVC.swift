import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit
import Photos
import ActionSheetController

class SignupCompleteVC: BaseVC {
    
    @IBOutlet weak var imgBg: UIImageView!
    
    @IBOutlet weak var imgDefault: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var tfBirthday: UITextField!
    
    
    @IBOutlet weak var lblWelcome: UIFontLabel!
    @IBOutlet weak var lblDesc: UIFontLabel!
    
    @IBOutlet weak var btnStart: UIFontButton!
    
    private var imgPicker: UIImagePickerController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLang()
//        initVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        imgBg.kf.setImage(with: URL(string: Local.getAppInfo().background_img!), options: [])
    }
    
    private func initLang() {
//        lblWelcome.text = String.init(format: "%@%@", Local.getUser().name!, getLangString("signup_welcome"))
//        lblDesc.text = getLangString("signup_complete_desc")
//        btnStart.setTitle(getLangString("signup_do_start"), for: .normal)
    }
    
    private func initVC() {
        imgProfile.isHidden = true
        
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
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
    
    private func onGallery() {
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        imgPicker.mediaTypes = ["public.image"]
        present(imgPicker, animated: false, completion: nil)
    }
    
    private func onCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imgPicker.sourceType = .camera
            imgPicker.mediaTypes = ["public.image"]
            imgPicker.allowsEditing = true
            imgPicker.showsCameraControls = true
            present(imgPicker, animated: false, completion: nil)
        } else {
//            self.view.showToast(getLangString("msg_no_support_camera"))
        }
    }
    
    private func setProfileImage(_ img: String) {
        imgDefault.isHidden = true
        imgProfile.isHidden = false
        self.imgProfile.kf.setImage(with: URL(string: img), options: [])
        
//        let user = Rest.user
//        user!.profile_img = img
//        Local.setUser(user!)
    }
}

//
// MARK: - Action
//
extension SignupCompleteVC: BaseAction {
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
//        VideoRegisterDialog.show(self, mediaType: "photo") { (action) in
//            if action == "camera" {
//                self.onCamera()
//            } else {
//                self.onGallery()
//            }
//        }
    }
    
    @IBAction func onClickBirthday(_ sender: Any) {
//        hideKeyboard()
        DatepickerDialog.show(self) { [weak self](date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self?.tfBirthday.text = dateFormatter.string(from: date)
//            self.isValidInput()
        }
    }
    
    @IBAction func onClickDoStart(_ sender: Any) {
//        replaceVC(MainVC(nibName: "vc_main", bundle: nil), animated: true)
    }
    
    @IBAction func onClickUseService(_ sender: Any) {

    }
}

//
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
//
extension SignupCompleteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerControllerDidCancel(picker)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            dismiss(animated: false, completion: nil)
            self.changeProfile(image: image)
        }
    }
}

//
// MARK: - RestApi
//
extension SignupCompleteVC: BaseRestApi {
    func changeProfile(image: UIImage) {
        SVProgressHUD.show()
//        Rest.changeProfile(file: image.jpegData(compressionQuality: 1), success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            let res = result as! ModelPhoto
//            self.setProfileImage(res.profile_img)
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
    }
}
