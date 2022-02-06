//
//  MainVC.swift
//  Traystorage
//
//  Created by Dev on 2021. 11. 28..
//

import UIKit
import REFrostedViewController
import SVProgressHUD

class MainVC: BaseVC {
    @IBOutlet weak var tableViewDocument: UITableView!
    @IBOutlet weak var tfSearchText: UITextField!
    
    @IBOutlet weak var vwEmptyView: UIView!
    @IBOutlet weak var vwDocumentView: UIView!
    @IBOutlet weak var lblDocumentCount: UILabel!
    @IBOutlet weak var lblSearchEmpty: UILabel!
    
    var documents: [ModelDocument] = []
    var lastKeyword:String?
        
    private var vcMenu: MenuVC?

    private enum Tab: Int {
        case home = 0
        case map = 1
        case search = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        loadDocument("")
    }

    private func initVC() {
        vcMenu = MenuVC(nibName: "vc_menu", bundle: Bundle.main)
        vcMenu?.delegate = self
        showPopup()
        
        vwEmptyView.isHidden = false
        vwDocumentView.isHidden = false
        lblSearchEmpty.isHidden = true
        
        let rightPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onPanOfRightEdge(_:)))
        rightPanGesture.edges = .all
        self.view.addGestureRecognizer(rightPanGesture)
    }
    
    @objc func onPanOfRightEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
        onClickMenu("")
    }

    private func showPopup() {
//        if Local.getNeverShowPopup() {
//            return
//        }
        
        LoadingDialog.show()
        Rest.popupInfo(success:{ [weak self](result) in
            LoadingDialog.dismiss()

            let popupList = result! as! ModelPopupList
            guard !popupList.contents.isEmpty else {
                return
            }
            
            let popup = popupList.contents[0]
            EveryDayDialog.show(self!, content: popup, notShowAction: nil, closeAction: nil) {[weak self] in
                self?.pushVC(NoticeDetailVC(nibName: "vc_notice_detail", bundle: nil), animated: true, params:["code": popup.movePath])
            }
        }, failure: { [weak self](code, err) in
            LoadingDialog.dismiss()
            self?.view.showToast(err)
        })


    }
    
    private func loadDocument(_ keyword: String) {
//        tableViewDocument.beginUpdates()
        self.documents.removeAll()
        tableViewDocument.reloadData()
//        tableViewDocument.endUpdates()
        
        lastKeyword = keyword
        
        LoadingDialog.show()
        Rest.documentList(keyword: keyword, success: {[weak self] (result) in
            LoadingDialog.dismiss()

            let documentList = result! as! ModelDocumentList
            self?.documents.append(contentsOf: documentList.contents)
            self?.documentChanged()
        }) {[weak self]  _, msg in
            LoadingDialog.dismiss()
            self?.view.showToast(msg)
        }
    }
    
    private func documentChanged() {
        tableViewDocument.reloadData()
        lblDocumentCount.text = "\(self.documents.count)" + "doc_gon"._localized

        let isEmptyDocList = self.documents.isEmpty
        
        if let keyword = lastKeyword, keyword.isEmpty {
            vwEmptyView.isHidden = !isEmptyDocList
            vwDocumentView.isHidden = isEmptyDocList
            lblSearchEmpty.isHidden = true
        } else {
            vwEmptyView.isHidden = true
            vwDocumentView.isHidden = false
            lblSearchEmpty.isHidden = !isEmptyDocList
        }
    }
    
    //
    // MARK: - Action
    //
    
    @IBAction func onClickTabHome(_ sender: Any) {
//        changeTab(Tab.home)
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        vcMenu?.slideOpen(self.view)
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        let vc = DocumentRegisterVC(nibName: "vc_document_register", bundle: nil);
        vc.isNewDocument = true
        vc.popDelegate = self
        pushVC(vc, animated: true)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
//        guard let searchText = tfSearchText.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty else {
//            self.view.showToast("doc_empty_search"._localized)
//            return
//        }
        
        let searchText = tfSearchText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        loadDocument(searchText)
    }
}


extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = cell.viewWithTag(1) as! UILabel
        let content = cell.viewWithTag(2) as! UILabel
        let tags = cell.viewWithTag(3) as! UILabel
        let imageView = cell.viewWithTag(4) as! UIImageView
        let labelView = cell.viewWithTag(5)!
        let date = cell.viewWithTag(6) as! UILabel
        
        let doc = documents[indexPath.row]
        title.text = doc.title
        content.text = doc.content
        if doc.tags.isEmpty {
            tags.text = ""
        } else {
            tags.text = "#" + doc.tags.joined(separator: " #")
        }
        date.text = doc.reg_time
        
        if doc.images.count > 0 {
            doc.setToImageView(at: 0, imageView: imageView)
        } else {
            imageView.image = nil
        }
        labelView.backgroundColor = AppColor.labelColors[doc.label]
        
        return cell
    }

}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DocumentDetailVC(nibName: "vc_document_detail", bundle: nil)
        detailVC.document = self.documents[indexPath.row]
        detailVC.popDelegate = self
        self.pushVC(detailVC, animated: true)
    }
}

//
// MARK: - MenuDelegate
//

extension MainVC: MenuDelegate {
    func openProfile() {
        self.pushVC(MyProfileVC(nibName: "vc_my_profile", bundle: nil), animated: true)
    }
    
    func openInvite() {
        self.pushVC(InviteVC(nibName: "vc_invite", bundle: nil), animated: true)
    }
    
    func openContactus() {
//        self.pushVC(ContactusVC(nibName: "vc_contactus", bundle: nil), animated: true)
        self.pushVC(InquiryVC(nibName: "vc_inquiry", bundle: nil), animated: true)
    }
    
    func openNotice() {
        self.pushVC(NoticeVC(nibName: "vc_notice", bundle: nil), animated: true)
    }
    
    func openSetting() {
        self.pushVC(SettingVC(nibName: "vc_setting", bundle: nil), animated: true)
    }
}

extension MainVC: PopViewControllerDelegate {
    func onWillBack(_ sender: String, _ result: Any?) {
        if sender == "insert" {
            onClickSearch("")
        } else if sender == "update" {
            onClickSearch("")
        } else if sender == "delete" {
            let documentID = result as! Int
            
            for i in 0..<documents.count {
                if documents[i].doc_id == documentID {
                    documents.remove(at: i)
                    documentChanged()
                    break
                }
            }
            
            self.view.showToast("doc_deleted_toast"._localized)
        }
    }
}
