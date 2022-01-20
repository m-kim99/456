//
//  MainVC.swift
//  Traystorage
//
//  Created by Dev on 2021. 11. 28..
//

import UIKit
import REFrostedViewController

class MainVC: BaseVC {
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var tfSearchText: UITextField!
    
    var documents: [ModelDocument] = []
        
    private var vcMenu: MenuVC?

    private enum Tab: Int {
        case home = 0
        case map = 1
        case search = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initVC()
        
        let image = UIImage(named: "img_Invitationmessage_150")!
        
        for i in 1...50 {
            let document = ModelDocument()
            document.title = "This is the data from the october ida meeting by " + String(i)
            document.content = "#Design Team #Meeting data#10M " + String(i)
            document.images.append(image)
            document.tags.append("1")
            document.tags.append("2")
            documents.append(document)
        }
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
            let popup = ModelPopup(dumyIndex: 0, dumyImage: "http://192.168.0.63:8005/assets/images/logo.png", dumyLink: "www.psjdc.com", dumyUrl: "http://192.168.0.63:8005/api/Article/home?platform=android")
            EveryDayDialog.show(self, content: popup, notShowAction: {() -> Void in
                Local.setNotShowAdsDate(now)
            })
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
        pushVC(DocumentRegisterVC(nibName: "vc_document_register", bundle: nil), animated: true)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        guard let searchText = tfSearchText.text, !searchText.isEmpty else {
            self.view.showToast("Please input a search text")
            return
        }
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
        let image = cell.viewWithTag(4) as! UIImageView
        
        let doc = documents[indexPath.row]
        title.text = doc.title
        content.text = doc.title
        tags.text = doc.tags.joined(separator: " # ")
        
        if doc.images.count > 0 {
            image.image = doc.images[0]
        } else {
            image.image = nil
        }
        
        return cell
    }

}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushVC(DocumentDetailVC(nibName: "vc_document_detail", bundle: nil), animated: true)
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
        self.pushVC(ContactusVC(nibName: "vc_contactus", bundle: nil), animated: true)
    }
    
    func openNotice() {
        self.pushVC(NoticeVC(nibName: "vc_notice", bundle: nil), animated: true)
    }
    
    func openSetting() {
        self.pushVC(SettingVC(nibName: "vc_setting", bundle: nil), animated: true)
    }
}
