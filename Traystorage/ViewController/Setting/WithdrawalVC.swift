import SVProgressHUD
import UIKit

class WithdrawalVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    private func initVC() {
    }
    
    //
    // MARK: - ACTION
    //
    

    @IBAction func onClickWithdrawal(_ sender: Any) {
        let vc = FindIdVC(nibName: "vc_find_id", bundle: nil)
        vc.findIDRequest = .withDrawal
        self.pushVC(vc, animated: true)
    }
}

//
// MARK: - RestApi
//
extension WithdrawalVC: BaseRestApi {
    func getContent(type: String, alarm_yn: String) {
//        LoadingDialog.show()
//        Rest.changeAlarm(type: type, alarm_yn: alarm_yn, success: { (result) -> Void in
//            LoadingDialog.dismiss()
//            if result?.result == 0 {
//                if type == "push" {
//                    self.user.alarm_push_yn = alarm_yn
//                    self.lblPushAllowValue.text = (self.user.alarm_push_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnPushAllow.isSelected = (self.user.alarm_push_yn == "y")
//                } else {
//                    self.user.alarm_challenge_yn = alarm_yn
//                    self.lblChallengeValue.text = (self.user.alarm_challenge_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnChallengeAlarm.isSelected = (self.user.alarm_challenge_yn == "y")
//                }
//
//                Local.setUser(self.user)
//            }
//        }, failure: { (_, err) -> Void in
//            LoadingDialog.dismiss()
//            self.view.showToast(err)
//        })
    }
}
