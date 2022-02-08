import SVProgressHUD
import UIKit

class VersionVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var vwCurrentVersion: UIStackView!
    @IBOutlet weak var lblCurrentVersion: UIFontLabel!
    @IBOutlet weak var lblVersionHeader: UIFontLabel!
    @IBOutlet weak var vwLatestVersion: UIStackView!
    @IBOutlet weak var lblLatestVersion: UIFontLabel!
    @IBOutlet weak var btnUpdate: UIFontButton!
    
    var latestVersion: ModelVersion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
        
        loadVerionInfo()
    }
    
    private func initVC() {
        lblVersionHeader.text = "version_header"._localized
        lblCurrentVersion.text = Utils.bundleVer()
        vwLatestVersion.isHidden = true
        btnUpdate.isHidden = true
    }
    
    private func showVersionInfo(_ latestVersion: ModelVersion) {
        self.latestVersion = latestVersion
        
        let curVersion = Utils.bundleVer()
        if latestVersion.version.isEmpty || curVersion.isEqual(latestVersion.version) {
            lblVersionHeader.text = "version_header1"._localized
            vwLatestVersion.isHidden = true
            btnUpdate.isHidden = true
            return;
        }
        
        vwLatestVersion.isHidden = false
        btnUpdate.isHidden = false
        lblLatestVersion.text = latestVersion.version
    }
    
    func go2Store(_ storeUrl: String) {
        guard let url = URL(string: storeUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    //
    // MARK: - ACTION
    //
    

    @IBAction func onUpdateVersion(_ sender: Any) {
        if let version = latestVersion {
            go2Store(version.storeUrl)
        }
    }
}

//
// MARK: - RestApi
//
extension VersionVC: BaseRestApi {
    func loadVerionInfo() {
        LoadingDialog.show()
        Rest.getVersionInfo(success: { [weak self](result) -> Void in
            LoadingDialog.dismiss()
            
            let version = result as! ModelVersion
            self?.showVersionInfo(version)
        }) { [weak self](_, err) -> Void in
            LoadingDialog.dismiss()
            self?.view.showToast(err)
        }
    }
}
