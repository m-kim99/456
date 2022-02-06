import SVProgressHUD
import UIKit

class WithdrawalResultVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    private func initVC() {
        lblDate.text = params["date"] as? String
    }
    
    //
    // MARK: - ACTION
    //
    

    @IBAction func onClickConfirm(_ sender: Any) {
        IntroVC.logOutProcess(self)
    }
}
