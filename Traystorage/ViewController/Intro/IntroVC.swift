import AuthenticationServices
import SVProgressHUD
import Toast_Swift
import UIKit

class IntroVC: BaseVC {
    @IBOutlet var pageScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var introView: UIView!
    @IBOutlet var loadingProgressView: UIView!
    @IBOutlet var startView: UIView!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loadingImage1: UIImageView!
    @IBOutlet var loadingImage2: UIImageView!
    @IBOutlet var loadingImage3: UIImageView!
    
    let pageCount = 2
    
    private var currentPage = 0
    
    var loadingImageOffset = 0
    var loadingImages: [UIImage] = []
    var loadingProgressTimer: Timer?
    private var snsManager: SnsManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snsManager = SnsManager(self)
        snsManager.delegate = self

        signupButton.layer.shadowOpacity = 0.2
        signupButton.layer.shadowOffset = CGSize.zero
        signupButton.layer.shadowRadius = 8
        signupButton.layer.masksToBounds = false
        
        loadingImages.append(UIImage(named: "loading1")!)
        loadingImages.append(UIImage(named: "loading2")!)
        loadingImages.append(UIImage(named: "loading3")!)

//        loadAppInfo()
//        nextScreen(false)
//        ConfirmDialog.show(self, title: "Please verify your mobile phone number.", message: "", showCancelBtn: true, okAction: nil)

        // pushVC(SignupCompleteVC(nibName: "vc_signup_complete", bundle: nil), animated: true)
        startIntro()
    }

    func startIntro() {
        let ud = UserDefaults.standard
        
        let isAutoLogin = ud.bool(forKey: Local.PREFS_APP_AUTO_LOGIN.rawValue)
        if isAutoLogin {
            checkVersion()
        } else {
            Local.deleteUser()
            
            let skipIntro = ud.bool(forKey: Local.PREFS_APP_INTRO_SKIP.rawValue)
            if skipIntro {
                checkVersion() // self.nextScreen(false)
            } else {
                changeLoadingViewVisiblity(isHidden: true)
                introView.isHidden = false
            }
        }
    }
    
    func startApp() {
        let user = Local.getUser()
        
        if let uid = user.uid, let pwd = user.pwd, !uid.isEmpty, !pwd.isEmpty {
            autoLogin((id: uid, pwd: pwd))
        } else {
            nextScreen(false)
            Local.removeAutoLogin()
        }
    }

    func nextScreen(_ logined: Bool) {
        if logined {
            openAgreeView()
        } else {
            let ud = UserDefaults.standard
            ud.set(true, forKey: Local.PREFS_APP_INTRO_SKIP.rawValue)
            ud.synchronize()
            openLogSingupView()
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
    
    func advanceLoaddingImage() {
        loadingImageOffset += 1
        loadingImageOffset %= 3
        
        loadingImage1.image = loadingImages[loadingImageOffset % 3]
        loadingImage2.image = loadingImages[(loadingImageOffset + 1) % 3]
        loadingImage3.image = loadingImages[(loadingImageOffset + 2) % 3]
    }
    
    func changeLoadingViewVisiblity(isHidden: Bool) {
        loadingProgressView.isHidden = isHidden
        if isHidden {
            stopLoadingProgressTimer()
        } else {
            startLoadingProgressTimer()
        }
    }
    
    func startLoadingProgressTimer() {
        stopLoadingProgressTimer()
        
        loadingProgressTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { [weak self] _ in
            self?.advanceLoaddingImage()
        })
    }
    
    func stopLoadingProgressTimer() {
        if let timer = loadingProgressTimer {
            timer.invalidate()
            loadingProgressTimer = nil
        }
    }
    
    static func logOutProcess(_ fromVC: UIViewController) {
        Local.deleteUser()
        Rest.user = nil
        Local.removeAutoLogin()
        
        if let nv = fromVC.navigationController {
            let vcs = nv.viewControllers
            for vc in vcs {
                if vc is IntroVC {
                    let introVC = vc as! IntroVC
                    introVC.openLogSingupView()
                    nv.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
    
    func onGetVersionSuccess(_ latestVersion: ModelVersion) {
        let curVersion = Utils.bundleVer()
        
        if latestVersion.version.isEmpty || curVersion.isEqual(latestVersion.version) {
            startApp()
            return
        }
        
        if latestVersion.requireUpdate == 1 {
            ConfirmDialog.show3(self, title: "update_version"._localized, message: "", okTitle: "update"._localized, cancelTitle: nil) { [weak self] result -> Void in
                if result == 0 {
                    self?.go2Store(latestVersion.storeUrl)
                } else {
                    self?.startApp()
                }
            }
        } else if let optionalVersion = Local.getAppVersion(), optionalVersion.isEqual(latestVersion.version) {
            startApp()
        } else {
            ConfirmDialog.show3(self, title: "update_version"._localized, message: "", okTitle: "update"._localized, cancelTitle: "later"._localized) { [weak self] result -> Void in
                if result == 0 {
                    self?.go2Store(latestVersion.storeUrl)
                } else {
                    if latestVersion.requireUpdate != 1 {
                        Local.setAppVersion(latestVersion.version)
                    }
                    self?.startApp()
                }
            }
        }
    }
    
    func go2Store(_ storeUrl: String) {
        guard let url = URL(string: storeUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
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
    
    func snsLogin(_id: String, _pwd: String, _type: Int) {
        changeLoadingViewVisiblity(isHidden: false)
        Rest.login(id: _id, pwd: _pwd, success: { [weak self] result -> Void in
            self?.changeLoadingViewVisiblity(isHidden: true)
            Rest.user = (result as! ModelUser)
            Rest.user.pwd = _pwd
            Local.setUser(Rest.user)
            self?.openAgreeView()
        }, failure: { [weak self] code, msg in
            self?.changeLoadingViewVisiblity(isHidden: true)
                
            let resposeCode = ResponseResultCode(rawValue: code) ?? .ERROR_SERVER
            let code = resposeCode.rawValue
            if code > 200 {
                let vc = SignupVC(nibName: "vc_signup", bundle: nil)
                vc.snsType = _type
                vc.snsID = _id
                self!.pushVC(vc, animated: true)
            }
        })
    }
}

//

// MARK: - RestApi

//
extension IntroVC: BaseNavigation {
    func openMainVC() {
        changeLoadingViewVisiblity(isHidden: true)
        let mainVC = UIStoryboard(name: "vc_main", bundle: nil).instantiateInitialViewController()
        pushVC(mainVC! as! BaseVC, animated: true)
    }
    
    func openAgreeView() {
        changeLoadingViewVisiblity(isHidden: true)
        if Rest.user.isAgree == 0 {
            pushVC(LoginAgreeTermsVC(nibName: "vc_login_agree_terms", bundle: nil), animated: true)
        } else {
            openMainVC()
        }
    }

    func openLogSingupView() {
//        self.replaceVC(GuideVC(nibName: "vc_guide", bundle: nil), animated: true)
        changeLoadingViewVisiblity(isHidden: true)
        introView.isHidden = true
        startView.isHidden = false
    }
    
    @IBAction func onSignup(_ sender: Any) {
        pushVC(SignupVC(nibName: "vc_signup", bundle: nil), animated: true)
    }
    
    @IBAction func onLogin(_ sender: Any) {
//        replaceVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
        pushVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
    }
    
    @IBAction func onSignupSNS(_ sender: UIButton) {
        // onSignup(sender)
        if sender.tag == 0 {
            // kakao
            snsManager.start(type: .Kakao)
        } else if sender.tag == 1 {
            // google
            snsManager.start(type: .Google)
        } else if sender.tag == 2 {
            // facebook
            snsManager.start(type: .Facebook)
        } else if sender.tag == 3 {
            // naver
            snsManager.start(type: .Naver)
        } else {
            // apple
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension IntroVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let err = error as? ASAuthorizationError

        var errKorMsg = ""
        if err!.errorCode == ASAuthorizationError.Code.failed.rawValue { // FAILED
        } else if err!.errorCode == ASAuthorizationError.Code.canceled.rawValue { // CANCELED
            errKorMsg = "apple_login_fail1".localized
        } else if err!.errorCode == ASAuthorizationError.Code.invalidResponse.rawValue { // INVALID_RESPONSE
            errKorMsg = "apple_login_fail2".localized
        } else if err!.errorCode == ASAuthorizationError.Code.notHandled.rawValue { // NOT_HANDLED
            errKorMsg = "apple_login_fail3".localized
        } else if err!.errorCode == ASAuthorizationError.Code.unknown.rawValue { // UNKNOWN
        }

        if errKorMsg == "" {
            return
        }
        let alert = UIAlertController(title: "alarm".localized, message: errKorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "confirm".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
            print("User Id - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.description ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")

            if let identityTokenData = appleIDCredential.identityToken,
               let identityTokenString = String(data: identityTokenData, encoding: .utf8)
            {
                print("Identity Token \(identityTokenString)")
            }

            let _appid = appleIDCredential.user
//            loginType = "7"
            let snsId = _appid.replacingOccurrences(of: ".", with: "")
            snsLogin(_id: snsId, _pwd: snsId, _type: 4)

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension IntroVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

//

// MARK: - RestApi

//
extension IntroVC: BaseRestApi {
//    func loadAppInfo() {
//        LoadingDialog.show()
//        Rest.appInfo(success: { (result) -> Void in
//            LoadingDialog.dismiss()
//            Local.setAppInfo(result as! ModelAppInfo)
//
//            DispatchQueue.global().async {
//                Thread.sleep(forTimeInterval: 1.0)
//                DispatchQueue.main.async {
//                    self.startApp()
//                }
//            }
//        }, failure: { (_, err) -> Void in
//            LoadingDialog.dismiss()
//            self.view.showToast(err)
//        })
//    }

    func autoLogin(_ user: (id: String, pwd: String)) {
//        LoadingDialog.show()
        changeLoadingViewVisiblity(isHidden: false)
        Rest.login(id: user.id, pwd: user.pwd, success: { [weak self] result -> Void in
//            LoadingDialog.dismiss()
            self?.changeLoadingViewVisiblity(isHidden: true)
            Rest.user = (result as! ModelUser)
            Rest.user.pwd = user.pwd
            Local.setUser(Rest.user)
            self?.openAgreeView()
        }, failure: { [weak self] code, msg in
            // LoadingDialog.dismiss()
            self?.changeLoadingViewVisiblity(isHidden: true)
            
            let resposeCode = ResponseResultCode(rawValue: code) ?? .ERROR_SERVER
            
            switch resposeCode {
            case .ERROR_SERVER:
//                AlertDialog.show(self?, title: "network_conect_fail_title"._localized, message: "network_conect_fail_desc"._localized);
                break
            case .ERROR_DB:
                break
            case .ERROR_USER_PAUSED:
                break
            case .ERROR_WRONG_PWD:
                Local.removeAutoLogin()
            default:
                self?.view.showToast(msg)
            }
            
//            if code == 205 {
            self?.openLogSingupView()
//            }
        })
    }
    
    func checkVersion() {
        changeLoadingViewVisiblity(isHidden: false)
        Rest.getVersionInfo(success: { [weak self] result -> Void in
            self?.changeLoadingViewVisiblity(isHidden: true)
            
            let version = result as! ModelVersion
            
            self?.onGetVersionSuccess(version)
        }, failure: { [weak self] _, _ in
            self?.changeLoadingViewVisiblity(isHidden: true)
            self?.showAlert(title: "network_conect_fail_title"._localized,
                            message: "network_conect_fail_desc"._localized)
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

extension IntroVC: SnsManagerDelegate {
    func snsAuthCompleted(_ me: SnsUserInfo) {
        var snsId = ""
        var type = 0
        switch me.user_login_type {
        case .Naver?:
            type = 2
            snsId = me.user_sns_id
        case .Kakao?:
            type = 5
            snsId = me.user_sns_id
        case .Facebook?:
            type = 3
            snsId = me.user_sns_id
        case .Google?:
            type = 1
            snsId = me.user_sns_id
        default:
            break
        }

        snsLogin(_id: snsId, _pwd: snsId, _type: type)
    }

    func snsAuthError(_ type: SnsType, msg: String) {
        self.view.showToast(msg)
    }
}
