import SVProgressHUD
import UIKit

class SettingVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    
    @IBOutlet weak var editID: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var lblVersion: UILabel!
    
    @IBOutlet var vwItems: [UIStackView]!
    private lazy var user: ModelUser = {
        return Rest.user
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    private func initVC() {
        for (index, menu) in vwItems.enumerated() {
            menu.tag = index
            menu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItem(_:))))
        }

        editID.text = user.uid
//        lblVersionValue.text = getLangString("setting_latest_version_using")
    }
    
    //
    // MARK: - ACTION
    //
    @IBAction func onEditPassword(_ sender: Any) {
        
    }
    
    @objc func onClickItem(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 0:
            self.pushVC(VersionVC(nibName: "vc_version", bundle: nil), animated: true)
            break
        case 1:
            self.pushVC(FaqVC(nibName: "vc_faq", bundle: nil), animated: true)
            break
        case 2:
            self.pushVC(LicenseVC(nibName: "vc_license", bundle: nil), animated: true)
        case 3:
            let vc = TermsVC(nibName: "vc_terms", bundle: nil)
            vc.pageType = .term
            self.pushVC(vc, animated: true)
        case 4:
            let vc = TermsVC(nibName: "vc_terms", bundle: nil)
            vc.pageType = .privacy
            self.pushVC(vc, animated: true)
        case 5:
            let vc = TermsVC(nibName: "vc_terms", bundle: nil)
            vc.pageType = .marketing
            self.pushVC(vc, animated: true)
        case 6:
            onClickLogout(1);
            break
        case 7:
            self.pushVC(WithdrawalVC(nibName: "vc_withdrawal", bundle: nil), animated: true)
        default:
            break
        }
    }
    
    @IBAction func onClickPwd(_ sender: Any) {
        ConfirmDialog.show(self, title:"setting_password_change_title"._localized, message: "setting_password_change_detail"._localized, showCancelBtn : true) { [weak self]() -> Void in
            
            let vc = FindIdVC(nibName: "vc_find_id", bundle: nil)
            vc.findIDRequest = .changePassword
            self?.pushVC(vc, animated: true)
        }
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        ConfirmDialog.show(self, title:"logout_alert_title"._localized, message: "", showCancelBtn : true) { [weak self]() -> Void in
            
            if let weakSelf = self {
                IntroVC.logOutProcess(weakSelf)
            }
        }
    }
}
