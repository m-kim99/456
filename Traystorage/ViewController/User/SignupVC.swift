import SVProgressHUD
import SwiftyJSON
import Toast_Swift
import UIKit
//import Material

enum SingupStep: Int {
    case first = 0
    case auth = 1
    case agree = 2
    case complete = 3
}

protocol SignupNextDelegate : NSObjectProtocol {
    func onClickNext(step: SingupStep, params: [String: Any])
}

class SignupVC: BaseVC {
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var vwSignupProgress: UIProgressView!
    
    weak var currentSignupPageVC: UIViewController?
    
    private var curTab = AuthType.phone
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onClickNext(step: .first, params:[:])
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        ConfirmDialog.show(self, title: "signup_cancel_alert_title".localized, message: "signup_cancel_alert_content"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.popToStartVC()
        }
    }
    
    
    private func onRecvDuplicated() {
        AlertDialog.show(self, title: "signup_duplicated_id_title"._localized, message: "signup_duplicated_id_detail"._localized)
    }
    
    private func addSignupPageView(view: UIView) {
        vwContent.addSubview(view)
        let views:[String:Any] = ["view" : view]

        let constraints1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: [], metrics: nil, views: views)
        let constraints2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: views)
        view.translatesAutoresizingMaskIntoConstraints = false

        vwContent.addConstraints(constraints1)
        vwContent.addConstraints(constraints2)
    }
}

//
// MARK: - Action
//
extension SignupVC: BaseAction {
}


extension SignupVC: SignupNextDelegate {
    func onClickNext(step: SingupStep, params: [String: Any]) {
        if let oldVC = currentSignupPageVC {
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParent()
            currentSignupPageVC = nil
        }
        
        switch step {
        case .first:
            let vc = SignupPage1VC(nibName: "vc_signup_page1", bundle: nil)
            vc.nextDelegate = self
            currentSignupPageVC = vc
            addSignupPageView(view: vc.view)
            self.addChild(vc)
            vwSignupProgress.progress = 0.33
        case .auth:
            let vc = SignupPage2VC(nibName: "vc_signup_page2", bundle: nil)
            vc.nextDelegate = self
            vc.params = params
            addSignupPageView(view: vc.view)
            
            self.addChild(vc)
            currentSignupPageVC = vc
            vwSignupProgress.progress = 0.66
        case .agree:
            let vc = SignupPage3VC(nibName: "vc_signup_page3", bundle: nil)
            vc.nextDelegate = self
            vc.params = params
            addSignupPageView(view: vc.view)
            
            self.addChild(vc)
            currentSignupPageVC = vc
            vwSignupProgress.progress = 1
        case .complete:
            let vc = SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil)
            self.pushVC(vc, animated: true)
        }
    }
}
