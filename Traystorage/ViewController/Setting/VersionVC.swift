import SVProgressHUD
import UIKit

class VersionVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
        
        loadVerionInfo()
    }
    
    private func initVC() {
    }
    
    private func showVersionInfo() {
        
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
extension VersionVC: BaseRestApi {
    func loadVerionInfo() {
        SVProgressHUD.show()
        Rest.getVersionInfo(success: { [weak self](result) -> Void in
            SVProgressHUD.dismiss()
        }) { [weak self](_, err) -> Void in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        }
    }
}
