import SVProgressHUD
import Toast_Swift
import UIKit

class IntroVC: BaseVC {
    @IBOutlet var pageScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    let pageCount = 2
    
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        SVProgressHUD.setBackgroundColor(UIColor.clear)
//        SVProgressHUD.setRingThickness(5)

//        loadAppInfo()
//        nextScreen(false)
//        ConfirmDialog.show(self, title: "Please verify your mobile phone number.", message: "", showCancelBtn: true, okAction: nil)
    }

    func startApp() {
//        let user = Local.getUser()
//        if user.id != nil && user.pwd != nil {
//            self.autoLogin((id: user.id, pwd: user.pwd))
//        } else {
            self.nextScreen(false)
//        }
    }

    func nextScreen(_ logined: Bool) {
        if logined {
            self.openMainVC()
        } else {
            self.openGuideVC()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onChangedPage(currentPage)
        pageScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(currentPage), y: 0), animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPage()
    }
    
    
    private func setupPage() {
        pageScrollView.contentOffset = CGPoint(x: view.frame.width * CGFloat(pageCount), y: 0)
        onChangedPage(currentPage)
        pageScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(currentPage), y: 0), animated: false)
    }
    
    func onChangedPage(_ index: Int!) {
        currentPage = index
        pageControl.currentPage = index
    }
    
    
    // MARK: - Action

    //

    @IBAction func onSwipe(_ sender: Any) {
        if let recognizer = sender as? UISwipeGestureRecognizer {
            if recognizer.direction == .left {
                if currentPage == 1 {
                    return
                }
                onChangedPage(currentPage + 1)
                pageScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(currentPage), y: 0), animated: true)
            } else if recognizer.direction == .right {
                if currentPage == 0 {
                    return
                }
                onChangedPage(currentPage - 1)
                pageScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(currentPage), y: 0), animated: true)
            }
        }
    }
    @IBAction func onClickSkip(_ sender: Any) {
        nextScreen(false)
    }
}

//
// MARK: - RestApi
//
extension IntroVC: BaseNavigation {
    func openMainVC() {
//        self.replaceVC(MainVC(nibName: "vc_main", bundle: nil), animated: true)
    }

    func openGuideVC() {
        self.replaceVC(GuideVC(nibName: "vc_guide", bundle: nil), animated: true)
    }
}

//
// MARK: - RestApi
//
extension IntroVC: BaseRestApi {
//    func loadAppInfo() {
//        SVProgressHUD.show()
//        Rest.appInfo(success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            Local.setAppInfo(result as! ModelAppInfo)
//
//            DispatchQueue.global().async {
//                Thread.sleep(forTimeInterval: 1.0)
//                DispatchQueue.main.async {
//                    self.startApp()
//                }
//            }
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
//    }
//
//    func autoLogin(_ user: (id: String?, pwd: String?)) {
//        SVProgressHUD.show()
//        Rest.login(id: user.id, pwd: user.pwd, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            if result!.result == 0 {
//                Rest.user = (result as! ModelUser)
//                Local.setUser(Rest.user)
//                self.openMainVC()
//            } else {
//                self.openGuideVC()
//            }
//        }, failure: { (code, msg) in
//            SVProgressHUD.dismiss()
//            self.view.showToast(msg)
//            if code == 205 {
//                self.openGuideVC()
//            }
//        })
//    }
}


extension IntroVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == pageScrollView {
            let offset = scrollView.contentOffset.x
            onChangedPage(Int(offset / scrollView.frame.size.width) % pageCount)
        }
    }
}
