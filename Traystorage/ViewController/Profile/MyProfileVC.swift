import SVProgressHUD
import UIKit
import Photos
import ActionSheetController

class MyProfileVC: BaseVC {

    @IBOutlet weak var vwAvatar: UIImageView!
    @IBOutlet weak var vwNameLabel: UIStackView!
    @IBOutlet weak var vwName: UIFontLabel!
    @IBOutlet weak var vwNameEdit: UIView!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var birthdayEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    override func removeFromParent() {
    }
    
    func initVC() {
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onChangeAvatar(_ sender: Any) {
    }
    @IBAction func onEditName(_ sender: Any) {
    }
    @IBAction func onSave(_ sender: Any) {
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
}
