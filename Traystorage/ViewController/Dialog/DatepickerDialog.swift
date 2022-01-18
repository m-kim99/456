import UIKit

class DatepickerDialog: BaseVC {
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var datepickerView: UIDatePicker!
    @IBOutlet weak var btnCancel: UIFontButton!
    @IBOutlet weak var btnConfirm: UIFontButton!
    @IBOutlet weak var vwContents: UIView!
    
    private var _selected: Callback?
    
    public typealias Callback = (_ date: Date) -> ()
    
    static func show(_ vc: UIViewController, selected: Callback?) {
        let popup = DatepickerDialog("dialog_datepicker", selected: selected)
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        vc.present(popup, animated: true, completion: nil)
    }
    
    convenience init(_ nibName: String?, selected: Callback?) {
        self.init(nibName: nibName, bundle: nil)
        
        self._selected = selected
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()

        lblTitle.text = getLangString("date_select")
        btnConfirm.setTitle(getLangString("confirm"), for: .normal)
        btnCancel.setTitle(getLangString("cancel"), for: .normal)
        
        datepickerView.maximumDate = Date()
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        vwContents.topCornerRadius = 30
    }
    
    private func close() {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @IBAction func onClickBg(_ sender: Any) {
        close()
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        dismiss(animated: true) {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self._selected?(self.datepickerView!.date)
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        close()
    }
}
