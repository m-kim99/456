//
//  EveryDayDialog.swift
//  IamGround
//
//  Created by Dev2 on 2021. 12. 15..
//

import UIKit
import WebKit

class EveryDayDialog: UIViewController {
    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwWeb: UIView!
    @IBOutlet weak var ivContent: UIImageView!
    private var webView: WKWebView!
    
    public typealias Callback = () -> Void
    private var notShowAction: Callback?
    private var content: ModelPopup!
    
    static func show(_ vc: UIViewController,
                     content: ModelPopup!, notShowAction: Callback? = nil) {
        
        let popup = EveryDayDialog("dialog_everyday", content: content, notShowAction: notShowAction)
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        vc.present(popup, animated: true, completion: nil)
    }
    
    convenience init(_ nibName: String?, content: ModelPopup!, notShowAction: Callback?) {
        self.init(nibName: nibName, bundle: nil)
        
        self.content = content
        self.notShowAction = notShowAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()

    }
    
    func initVC() {
        vwBg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClose(_:))))
        vwRoot.frame = UIScreen.main.bounds
        
        if content.image == "" {
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            let configuration = WKWebViewConfiguration()
            configuration.preferences = preferences
            webView = WKWebView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height - 219)), configuration: configuration)
            webView.backgroundColor = AppColor.white
            webView.scrollView.backgroundColor = AppColor.white
            webView.isOpaque = false
            vwWeb.addSubview(webView)
            ivContent.isHidden = true
            
            if let url = URL(string: content.url) {
                let request = URLRequest(url: url)
                webView.load(request)
            }

        } else {
            vwWeb.isHidden = true
            ivContent.kf.setImage(with: URL(string: content.image))
            ivContent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickImage(_:))))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    //
    // MARK: - Action
    //
    @IBAction func onNotSeeToday(_ sender: Any) {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.notShowAction?()
        }
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @objc func onClickImage(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: content.link)! as URL, options: [:], completionHandler: nil)
    }
}
