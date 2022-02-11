import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit

class CheckIdVC: BaseVC {
    
    @IBOutlet weak var lblLoginID: UILabel!
    
    var userLoginID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginID = params["userID"] as! String
//        if userLoginID.count > 4 {
//            lblLoginID.text = "****\(userLoginID.substring(from: 4))"
//        } else {
            lblLoginID.text = userLoginID
//        }
    }
    
    //
    // MARK: - Action
    //
    
    @IBAction func onFindPassword(_ sender: Any) {
        self.pushVC(FindPwdVC(nibName: "vc_findpwd", bundle: nil), animated: true, params:["userID" : userLoginID])
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        if let nv = self.navigationController {
            let vcs = nv.viewControllers
            for vc in vcs {
                if vc is LoginVC {
                    let logVC = vc as! LoginVC
                    logVC.resetLoginInputInformation()
                    logVC.setLoginID(userID: userLoginID)
                    nv.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
}
