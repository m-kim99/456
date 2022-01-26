import SVProgressHUD
import Toast_Swift
import UIKit

class IntroVC: BaseVC {
    @IBOutlet var pageScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var introView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var startView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    
    let pageCount = 2
    
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.shadowOpacity = 0.2
        signupButton.layer.shadowOffset = CGSize.zero
        signupButton.layer.shadowRadius = 8
        signupButton.layer.masksToBounds = false

//        SVProgressHUD.setBackgroundColor(UIColor.clear)
//        SVProgressHUD.setRingThickness(5)

//        loadAppInfo()
//        nextScreen(false)
//        ConfirmDialog.show(self, title: "Please verify your mobile phone number.", message: "", showCancelBtn: true, okAction: nil)
        
        startApp()
    }

    func startApp() {
        let ud = UserDefaults.standard
        
        let isAutoLogin = ud.bool(forKey: Local.PREFS_APP_AUTO_LOGIN.rawValue)
        if  isAutoLogin {
            let user = Local.getUser()
            
            if let uid = user.uid, let pwd = user.pwd, !uid.isEmpty, !pwd.isEmpty {
                self.autoLogin((id: uid, pwd: pwd))
            } else {
                self.nextScreen(false)
                Local.removeAutoLogin()
            }
        } else {
            Local.deleteUser()
            
            let skipIntro = ud.bool(forKey: Local.PREFS_APP_INTRO_SKIP.rawValue)
            if skipIntro {
                self.nextScreen(false)
            } else {
                backgroundView.isHidden = true
                introView.isHidden = false;
            }
        }
    }

    func nextScreen(_ logined: Bool) {
        if logined {
            self.openMainVC()
        } else {
            let ud = UserDefaults.standard
            ud.set(true, forKey: Local.PREFS_APP_INTRO_SKIP.rawValue)
            ud.synchronize()
            self.openLogSingupView()
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
        let mainVC = UIStoryboard(name: "vc_main", bundle: nil).instantiateInitialViewController()
        self.pushVC(mainVC! as! BaseVC, animated: true)
    }

    func openLogSingupView() {
//        self.replaceVC(GuideVC(nibName: "vc_guide", bundle: nil), animated: true)
        self.backgroundView.isHidden = true
        self.introView.isHidden = true
        self.startView.isHidden = false
    }
    
    @IBAction func onSignup(_ sender: Any) {
        pushVC(SignupVC(nibName: "vc_signup", bundle: nil), animated: true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
//        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
        pushVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
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

    func autoLogin(_ user: (id: String, pwd: String)) {
        SVProgressHUD.show()
        Rest.login(id: user.id, pwd: user.pwd, success: {[weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
                Rest.user = (result as! ModelUser)
                Rest.user.pwd = user.pwd
                Local.setUser(Rest.user)
                self?.openMainVC()
            } else {
                Local.removeAutoLogin()
                self?.view.showToast(ret.msg)
                self?.openLogSingupView()
            }
        }, failure: { [weak self](code, msg) in
            SVProgressHUD.dismiss()
            Local.removeAutoLogin()
            self?.view.showToast(msg)
//            if code == 205 {
                self?.openLogSingupView()
//            }
        })
    }
}


extension IntroVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == pageScrollView {
            let offset = scrollView.contentOffset.x
            onChangedPage(Int(offset / scrollView.frame.size.width) % pageCount)
        }
    }
}
