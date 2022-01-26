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
    
    var documents: [ModelDocument] = []
    var isFirstLoadDocument = false
        
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
//        showEverydayPopup()
    }
    
    func showEverydayPopup() {
        
        let date_not = Local.getNotShowAdsDate()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let now = String(format: "%04d-%02d-%02d", components.year!, components.month!, components.day!)
        
        if date_not!.isEmpty || now != date_not {
//            let popup = ModelPopup(dumyIndex: 0, dumyImage: "http://192.168.0.63:8005/assets/images/logo.png", dumyLink: "www.psjdc.com", dumyUrl: "http://192.168.0.63:8005/api/Article/home?platform=android")
//            EveryDayDialog.show(self, content: popup, notShowAction: {() -> Void in
//                Local.setNotShowAdsDate(now)
//            })
        }
    }
    
    private func showPopup(_ now: String) {
        SVProgressHUD.show()
        Rest.popupInfo(success:{ [weak self](result) in
            SVProgressHUD.dismiss()
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
//                EveryDayDialog.show(self!, content: ret, notShowAction: {() -> Void in
//                    Local.setNotShowAdsDate(now)
//                })
            } else {
                self?.view.showToast(ret.msg)
            }
        }, failure: { [weak self](code, err) in
            SVProgressHUD.dismiss()
            self?.view.showToast(err)
        })


    }
    
    private func loadDocument(_ keyword: String) {
        self.documents.removeAll()
        SVProgressHUD.show()
        Rest.documentList(keyword: tfSearchText.text ?? "", success: {[weak self] (result) in
            SVProgressHUD.dismiss()
            guard let result = result, result.result == 0 else {
                return
            }
            
            guard let documentList = result as? ModelDocumentList else {
                return
            }

            self?.documents.append(contentsOf: documentList.contents)
            self?.documentChanged()
        }, failure: { _, msg in
            SVProgressHUD.dismiss()
        })
    }
    
    private func documentChanged() {
        tableViewDocument.reloadData()
        lblDocumentCount.text = "\(self.documents.count)"

        let isEmptyDocList = self.documents.isEmpty
        
        if !isFirstLoadDocument {
            isFirstLoadDocument = true
            vwEmptyView.isHidden = !isEmptyDocList
            vwDocumentView.isHidden = isEmptyDocList
        } else if isEmptyDocList == false {
            vwEmptyView.isHidden = !isEmptyDocList
            vwDocumentView.isHidden = isEmptyDocList
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
        
        let doc = documents[indexPath.row]
        title.text = doc.title
        content.text = doc.title
        tags.text = doc.tags.joined(separator: " #")
        
        if doc.imagesUrlList.isEmpty {
            imageView.image = nil;
        } else if let imageURL = doc.imagesUrlList[0] {
            imageView.kf.setImage(with: URL(string: imageURL))
        } else {
            imageView.image = doc.images[0]
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
        }
    }
}
