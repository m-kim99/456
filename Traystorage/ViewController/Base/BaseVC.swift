import SVProgressHUD
import UIKit

protocol PopViewControllerDelegate {
    func onWillBack(_ sender: String, _ result: Any?)
}

class BaseVC: UIViewController {
    var params: [String: Any] = [:]
    var popDelegate: PopViewControllerDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setContainerView(self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.unregisterForKeyboardNotifications()
        SVProgressHUD.popActivity()
        SVProgressHUD.dismiss()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseVC.keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseVC.keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(_ aNotification: Notification) {}
    
    @objc func keyboardWillBeHidden(_ aNotification: Notification) {}
  
    func replaceVC(_ identifier: String, storyboard: String, animated: Bool) {
        let nav: UINavigationController! = self.navigationController
        let storyboard: UIStoryboard! = UIStoryboard(name: storyboard, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        nav.setViewControllers([vc], animated: animated)
    }
  
    func pushVC(_ identifier: String, storyboard: String, animated: Bool) {
        let nav: UINavigationController! = self.navigationController
        let storyboard: UIStoryboard! = UIStoryboard(name: storyboard, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        nav.pushViewController(vc, animated: animated)
    }
  
    func pushVC(_ identifier: String, storyboard: String, animated: Bool, params: [String: Any]) {
        let nav: UINavigationController! = self.navigationController
        let storyboard: UIStoryboard! = UIStoryboard(name: storyboard, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as! BaseVC
        
        vc.params = params
        nav.pushViewController(vc, animated: animated)
    }
    
    func pushVC(_ vc: BaseVC, animated: Bool, params: [String: Any] = [:]) {
        let nav: UINavigationController! = self.navigationController
        vc.params = params
        nav.pushViewController(vc, animated: animated)
    }
    
    func replaceVC(_ vc: BaseVC, animated: Bool, params: [String: Any] = [:]) {
        let nav: UINavigationController! = self.navigationController
        vc.params = params
        nav.setViewControllers([vc], animated: animated)
    }
  
    @objc func popVC(_ backStep: Int32 = -1, animated: Bool = true) {
        let nav: UINavigationController! = self.navigationController
        
        if nav == nil {
            return
        }
    
        var viewVCs: [UIViewController] = nav.viewControllers
        for _ in 1 ... (0 - backStep) {
            viewVCs.removeLast()
        }
    
        nav.setViewControllers(viewVCs, animated: animated)
    }
  
    func presentVC(_ identifier: String, storyboard: String, animated: Bool) {
        let storyboard: UIStoryboard! = UIStoryboard(name: storyboard, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: animated, completion: nil)
    }
  
    func displayContentController(content: UIViewController) {
        addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
    }
  
    func hideContentController(content: UIViewController) {
        content.willMove(toParent: nil)
        content.removeFromParent()
        content.view.removeFromSuperview()
    }
}
