//
//  ContactusVC.swift
//  Traystorage
//

import Foundation
import UIKit

class ContactusVC: BaseVC {
    @IBOutlet var tfSubject: UITextField!
    @IBOutlet var tvDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    override func removeFromParent() {
    }
    
    func initVC() {
    }
    
    override func hideKeyboard() {
        tfSubject.resignFirstResponder()
        tvDetail.resignFirstResponder()
    }
    
    
    @IBAction func onClickSend(_ sender: Any) {
        hideKeyboard()
        
        guard let subject = tfSubject.text?.trimmingCharacters(in: CharacterSet.whitespaces), !subject.isEmpty else {
            self.view.showToast("Please input a valid subject")
            return
        }
        
        guard let content = tvDetail.text?.trimmingCharacters(in: CharacterSet.whitespaces), !content.isEmpty else {
            self.view.showToast("Please input a inqury content")
            return
        }
        
        if content.count < 10 {
            self.view.showToast("Please input 10+ charaters for content")
            return
        }
        
        ConfirmDialog.show(self, title: "Send", message: "Would you like to inquire about what you have written?", showCancelBtn: true) { [weak self]() -> Void in
            self?.popToGuidVC()
        }
    }
}

extension ContactusVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfSubject, newLen > 30 {
            return false
        }

        return true
    }
}
