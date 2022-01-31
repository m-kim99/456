import SVProgressHUD
import UIKit

class WithdrawalResultVC: BaseVC {

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
    

    @IBAction func onClickConfirm(_ sender: Any) {
        IntroVC.logOutProcess(self)
    }
}
