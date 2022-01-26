import SVProgressHUD
import UIKit

class LicenseVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    
    @IBOutlet weak var tvList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    private func initVC() {
        tvList.register(UINib(nibName: "tvc_license", bundle: nil), forCellReuseIdentifier: "LicenseTVC")
    }
    
    //
    // MARK: - ACTION
    //

    @IBAction func onUpdateVersion(_ sender: Any) {
    }
}

//
// MARK: - RestApi
//
extension LicenseVC: BaseRestApi {
    func updateList(type: String, alarm_yn: String) {
//        SVProgressHUD.show()
//        Rest.changeAlarm(type: type, alarm_yn: alarm_yn, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
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
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
    }
}

//
// MARK: - UITableViewDataSource, UITableViewDelegate
//
extension LicenseVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LicenseTVC", for: indexPath) as! LicenseTVC
//        cell.setData(data: ModelPaymentHistoryStadium(), delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
    
}

extension LicenseVC: LicenseTVCDelegate {
    
}
