import Foundation
import UIKit

class ConfirmDialog: BaseVC {
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var vwRoot: UIView!
    
    public typealias Callback = () -> ()
    
    private var okAction: Callback?
    
    private var caption: String!
    private var content: String!
    private var showCancelBtn = false
    
    static func show(_ vc: UIViewController,
                     title: String!,
                     message: String!,
                     showCancelBtn: Bool!,
                     okAction: Callback? = nil) {
        let popup = ConfirmDialog("dialog_confirm", title: title, message: message, showCancelBtn: showCancelBtn, okAction: okAction)
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        vc.present(popup, animated: true, completion: nil)
    }
    
    convenience init(_ nibName: String?, title: String!, message: String!, showCancelBtn: Bool!, okAction: Callback?) {
        self.init(nibName: nibName, bundle: nil)
        
        self.caption = title
        self.content = message
        self.okAction = okAction
        self.showCancelBtn = showCancelBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = caption
        lblContent.text = content
//        btnYes.setTitle(getLangString("confirm"), for: .normal)
//        btnCancel.setTitle(getLangString("cancel"), for: .normal)
        
        if (self.showCancelBtn == false) {
            self.btnCancel.isHidden = true
//            let newConstraint = self.constraintBtnYes.constraintWithMultiplier(1)
//            self.view!.removeConstraint(self.constraintBtnYes)
//            self.view!.addConstraint(constraintBtnYes)
//            self.view!.layoutIfNeeded()
        }
        
        vwBg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickNo(_:))))
        
        vwRoot.frame = UIScreen.main.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Action
    //
    @IBAction func onClickYes(_ sender: Any) {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.okAction?()
        }
    }
    
    @IBAction func onClickNo(_ sender: Any) {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}

