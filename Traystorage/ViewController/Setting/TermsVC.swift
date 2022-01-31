import SVProgressHUD
import UIKit
import WebKit

enum WebPageType: Int {
    case term = 0
    case privacy = 1
    case marketing = 2
}

class TermsVC: BaseVC {
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var vwTermsWeb: WKWebView!
    
    var pageType: WebPageType = .term
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch pageType {
        case .term:
            params["title"] = "terms_of_use"._localized
            params["url"] = API_TERM_URL
        case .privacy:
            params["title"] = "privacy_policy"._localized
            params["url"] = API_PRIVACY_URL
        case .marketing:
            params["title"] = "marketing_consent"._localized
            params["url"] = API_MARKETING_URL
        }
        
        initVC()
    }
    
    private func initVC() {
        if let title = params["title"] as? String {
            lblPageTitle.text = title
        }
        
        if let url = params["url"] as? String {
            let myURL = URL(string: url)
            let myRequest = URLRequest(url: myURL!)
            vwTermsWeb.load(myRequest)
        }
    }
    
    //
    // MARK: - ACTION
    //
    
}
