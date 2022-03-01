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
    
    @IBOutlet weak var lblCountTitle: UIFontLabel!
    @IBOutlet weak var vwHeaderMain: UIView!
    @IBOutlet weak var vwHeaderSearch: UIView!
    @IBOutlet weak var btnDocRegister: UIButton!
    
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
        updateViewContent(isSearchResult:false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(docReg), name: NSNotification.Name(rawValue: "doc_reg"), object: nil)
    }

    private func initVC() {
        vcMenu = MenuVC(nibName: "vc_menu", bundle: Bundle.main)
        vcMenu?.delegate = self
        showPopup()
        
        vwEmptyView.isHidden = false
        vwDocumentView.isHidden = false
        lblSearchEmpty.isHidden = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let link = Local.getDimLink()
        if link != "" {
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 0.5)
                DispatchQueue.main.async {
                    self.goDetailPage()
                }
            }
            return
        }
    }
    
    @objc func docReg(_ notification: NSNotification) {
        loadDocument("", showLoading: true)
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            onClickMenu("")
        }
    }

    private func updateViewContent(isSearchResult:Bool) {
        let searchText = tfSearchText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if isSearchResult {
            if searchText.isEmpty {
                self.view.showToast("doc_empty_search"._localized)
                return
            }
        }
        vwHeaderMain.isHidden = isSearchResult
        vwHeaderSearch.isHidden = !isSearchResult
        btnDocRegister.isHidden = isSearchResult
        lblCountTitle.text = isSearchResult ? "search_result"._localized : "doc_count"._localized
        
        if isSearchResult {
            loadDocument(searchText, showLoading: true)
        } else {
            tfSearchText.text = nil
            loadDocument("", showLoading: true)
        }
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
    
    private func loadDocument(_ keyword: String, showLoading:Bool) {
//        tableViewDocument.beginUpdates()
        self.documents.removeAll()
        tableViewDocument.reloadData()
//        tableViewDocument.endUpdates()
        
        lastKeyword = keyword
        
        if showLoading {
            LoadingDialog.show()
        }
        Rest.documentList(keyword: keyword, success: {[weak self] (result) in
            if showLoading {
                LoadingDialog.dismiss()
            }
            
            let documentList = result! as! ModelDocumentList
            self?.documents.removeAll()
            self?.documents.append(contentsOf: documentList.contents)
            self?.documentChanged()
        }) {[weak self]  code, msg in
            if showLoading {
                LoadingDialog.dismiss()
            }
            if code == 1 {
                self?.view.showToast("login_token_error".localized)
                self?.pushVC(LoginVC(nibName: "vc_login", bundle: nil), animated: true)
            } else {
                self?.view.showToast(msg)
            }
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
            lblSearchEmpty.text = "search_empty_title"._localized + (lastKeyword ?? "")
            lblSearchEmpty.isHidden = !isEmptyDocList
        }
    }
    
    //
    // MARK: - Action
    //
    @IBAction func onSearchDone(_ sender: Any) {
        updateViewContent(isSearchResult: true)
    }
    
    @IBAction func onSearchResultBack(_ sender: Any) {
        updateViewContent(isSearchResult: false)
    }
    
    internal override func hideKeyboard() {
        super.hideKeyboard()
        tfSearchText.resignFirstResponder()
    }
    
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
        hideKeyboard()

        updateViewContent(isSearchResult: true)
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
        labelView.borderColor = .black
        if doc.label == 0 {
            labelView.borderWidth = 1.0
        } else {
            labelView.borderWidth = 0
        }
        
        return cell
    }

}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DocumentDetailVC(nibName: "vc_document_detail", bundle: nil)
        detailVC.documentId = self.documents[indexPath.row].doc_id
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
            loadDocument(lastKeyword ?? "", showLoading: false)
        } else if sender == "update" {
            loadDocument(lastKeyword ?? "", showLoading: false)
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
