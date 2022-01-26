//
//  InquiryVC.swift
//  Traystorage
//

import Foundation
import UIKit
import SVProgressHUD

class InquiryVC: BaseVC {
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var vwEmpty: UIView!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var lblCount: UILabel!
    
    var askList:[ModelCard] = []
    var askListExpend:[Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        
        updateList()
    }
    
    private func refreshList() {
        self.tvList.reloadData()
        vwEmpty.isHidden = !self.askList.isEmpty
        vwContent.isHidden = self.askList.isEmpty
        lblCount.text = "\(self.askList.count)"
    }
    
    func initVC() {
        tvList.register(UINib(nibName: "tvc_inquiry", bundle: nil), forCellReuseIdentifier: "InquiryTVC")

    }

    @IBAction func onContactus(_ sender: Any) {
        self.pushVC(ContactusVC(nibName: "vc_contactus", bundle: nil), animated: true)
    }
}

//
// MARK: - RestApi
//
extension InquiryVC: BaseRestApi {
    func updateList() {
        SVProgressHUD.show()
        Rest.getAskList(success: { [weak self] (result) -> Void in
            SVProgressHUD.dismiss()
            
            guard let ret = result else {
                return
            }
            
            if ret.result == 0 {
                let cardList = ret as! ModelCardList
                for card in cardList.list {
                    if card != nil {
                        self?.askList.append(card!)
                        self?.askListExpend.append(false)
                    }
                }
                
                self?.refreshList()
            } else {
                self?.view.showToast(ret.msg)
            }
        }, failure: { (_, err) -> Void in
            SVProgressHUD.dismiss()
            self.view.showToast(err)
        })
    }
}

//
// MARK: - UITableViewDataSource, UITableViewDelegate
//
extension InquiryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return askList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InquiryTVC", for: indexPath) as! InquiryTVC
        
        let index = indexPath.row
        let ask = askList[index]
        cell.lblTitle.text = ask.title
        cell.lblDate.text = ask.create_time
        cell.lblDetail.text = ask.content
        
        cell.isExpand = askListExpend[index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        askListExpend[index] = !askListExpend[index]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
