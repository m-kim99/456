import SVProgressHUD
import UIKit

class FaqVC: BaseVC {

    @IBOutlet weak var lblPageTitle: UIFontLabel!
    
    @IBOutlet weak var cvCategory: UICollectionView!
    @IBOutlet weak var tvList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    private func initVC() {
        cvCategory.dataSource = self
        cvCategory.delegate = self
        cvCategory.register(UINib(nibName: "cvc_faq", bundle: nil), forCellWithReuseIdentifier: "FaqCVC")

        tvList.dataSource = self
        tvList.delegate = self
        tvList.register(UINib(nibName: "tvc_faq", bundle: nil), forCellReuseIdentifier: "FaqTVC")

    }
    
    //
    // MARK: - ACTION
    //
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    

    @IBAction func onUpdateVersion(_ sender: Any) {
    }
}

//
// MARK: - RestApi
//
extension FaqVC: BaseRestApi {
    func updateList(type: String, alarm_yn: String) {
//        SVProgressHUD.show()
//        Rest.changeAlarm(type: type, alarm_yn: alarm_yn, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            if result?.result == 0 {
//                if type == "push" {
//                    self.user.alarm_push_yn = alarm_yn
//                    self.lblPushAllowValue.text = (self.user.alarm_push_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnPushAllow.isSelected = (self.user.alarm_push_yn == "y")
//                } else {
//                    self.user.alarm_challenge_yn = alarm_yn
//                    self.lblChallengeValue.text = (self.user.alarm_challenge_yn == "y") ? getLangString("setting_on") : getLangString("setting_off")
//                    self.btnChallengeAlarm.isSelected = (self.user.alarm_challenge_yn == "y")
//                }
//
//                Local.setUser(self.user)
//            }
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
    }
}

//
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
//

extension FaqVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaqCVC", for: indexPath) as! FaqCVC
//        cell.setData(area: self.areaList[indexPath.row], selectedArea: selectedArea)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
//        self.selectedArea = self.areaList[indexPath.row]
//        lblSubTitle.text = self.areaList[indexPath.row]
//        cvArea.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let area = areaList[indexPath.row];
//        return CGSize(width: area.widthToFit(collectionView.bounds.size.height, UIFont.systemFont(ofSize: 12)) + 25, height: 30)
//        return CGSize(width:10, height:10)
//    }
}

//
// MARK: - UITableViewDataSource, UITableViewDelegate
//
extension FaqVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTVC", for: indexPath) as! FaqTVC
        cell.setData(data: ModelPaymentHistoryStadium(), delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
    
}

extension FaqVC: FaqTVCDelegate {
    
    func onClickCell(_ model: ModelPaymentHistoryStadium) {
//        self.pushVC(RefundVC(nibName: "vc_refund", bundle: nil), animated: true, params: params)
    }
}
