import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class CheckIdVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    // MARK: - Action
    //
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onFindPassword(_ sender: Any) {
        self.pushVC(FindIdVC(nibName: "vc_find_id", bundle: nil), animated: true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        popToLogVC(true)
    }
}


//
// MARK: - RestApi
//
extension CheckIdVC: BaseRestApi {
    func resetPwd() {
        SVProgressHUD.show()
//        Rest.resetPwd(email: tfEmail.text, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            self.onResetSuccess()
//        }, failure: { (code, err) -> Void in
//            SVProgressHUD.dismiss()
//            if code == 202 {
//                self.showError(err)
//                return
//            }
//            self.view.showToast(err)
//        })
    }
}
