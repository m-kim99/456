import SVProgressHUD
import UIKit
import PullToRefresh

class DocumentDetailVC: BaseVC {
    @IBOutlet var tvChallenge: UITableView!
    @IBOutlet weak var lblChallengeName: UILabel!
    
    private var imageList: [UIImage] = []
    private var pageNo = 0
    private var isLast = false
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    
    let viewTagImageCollectionView = 1
    let viewTagTagCollectionView = 2
    
    private var refreshControl = UIRefreshControl()
    
    var document: ModelDocument = ModelDocument()
    
//    private lazy var challenge: ModelChallenge? = {
//        params["challenge"] as? ModelChallenge
//    }()
//
//    private lazy var user: ModelUser = {
//        Rest.user
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...10 {
            document.tags.append("tag" + i.description)
        }
        
        let image = UIImage(named: "Group 32")!
        for _ in 1...3 {
            document.images.append(image)
        }
        
//        initVC()
//        initPullToRefresh()
//        loadChallengeDetail(challenge?.challenge_uid)
        
        imageCollectionView.register(UINib(nibName: "item_image", bundle: nil), forCellWithReuseIdentifier: "cell")
        tagCollectionView.register(UINib(nibName: "item_tag", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       self.pageNo = 0
       self.isLast  = false
//       loadVideoList(page: 0)
    }
    
//    private func initVC() {
//        tvChallenge.dataSource = self
//        tvChallenge.delegate = self
//        tvChallenge.register(UINib(nibName: "item_challenge_detail", bundle: nil), forCellReuseIdentifier: "ChallengeDetailTVC")
//        tvChallenge.register(UINib(nibName: "item_challenge_video_1", bundle: nil), forCellReuseIdentifier: "ChallengeVideoTVC1")
//        tvChallenge.register(UINib(nibName: "item_challenge_video_2", bundle: nil), forCellReuseIdentifier: "ChallengeVideoTVC2")
//    }
    
//    private func initPullToRefresh() {
//        refreshControl.addTarget(self, action: #selector(refreshVideo), for: .valueChanged)
//        tvChallenge.addSubview(refreshControl)
//    }
    
//    @objc func refreshVideo(sender:AnyObject) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
//            self.pageNo = 0
//            self.loadVideoList(page: 0)
//        })
//    }

    //

    // MARK: - ACTION

    //
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickTrash(_ sender: Any) {
        ConfirmDialog.show2(self, title: "If you delete a documentm the document is not exposed when using NFC tags", message: "Are you sure to want to delte this document?", showCancelBtn: true) { [weak self]() -> Void in
            self?.popVC()
        }
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        pushVC(DocumentRegisterVC(nibName: "vc_document_edit", bundle: nil), animated: true, params: params as [String : Any])
    }
    
    @IBAction func onClickNFCRegister(_ sender: Any) {
        pushVC(DocumentNFCRegisterVC(nibName: "vc_document_nfc_register", bundle: nil), animated: true, params: params as [String : Any])
    }
}

//

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate


extension DocumentDetailVC: UICollectionViewDataSource, UICollectionViewDelegate/*, ChallengeVideoTVCDelegate, ChallengeDetailTVCDelegate*/ {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewTag = collectionView.tag
        switch collectionViewTag {
        case viewTagImageCollectionView:
            return document.images.count
        case viewTagTagCollectionView:
            return document.tags.count
        default:
            break
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let closeButton = cell.viewWithTag(10) as? UIButton {
            closeButton.removeFromSuperview()
        }

        let collectionViewTag = collectionView.tag
        
        if let contentView = cell.viewWithTag(5) {
            contentView.backgroundColor = UIColor.clear
        }
        
        switch collectionViewTag {
        case viewTagImageCollectionView:
            if let imageView = cell.viewWithTag(2) as? UIImageView {
                imageView.image = document.images[indexPath.row]
            }
            break
        case viewTagTagCollectionView:
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = "#" + document.tags[indexPath.row]
            }
            break
        default:
            break
        }
        
        return cell
    }
}

////
//
//// MARK: - Navigation
//
////
//extension ChallengeDetailVC: BaseNavigation {
//    private func goVideoDetail(model: ModelVideo) {
//        let params = ["videoUid": model.video_uid]
//        pushVC(VideoDetailVC(nibName: "vc_video_detail", bundle: nil), animated: true, params: params as [String : Any])
//    }
//}
//
////
//
//// MARK: - RestApi
//
////
//extension ChallengeDetailVC: BaseRestApi {
//    func loadChallengeDetail(_ challenge_uid: Int!) {
//        SVProgressHUD.show()
//        Rest.challengeDetail(challenge_uid: challenge_uid, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            self.challenge = (result as! ModelChallenge)
//            self.tvChallenge.reloadData()
//            self.lblChallengeName.text = self.challenge?.name
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
//    }
//
//    func loadVideoList(page: Int) {
//        if (!refreshControl.isRefreshing) {
//            SVProgressHUD.show()
//        }
//
//        self.pageNo = page
//        Rest.videoList(page: page, challenge_uid: challenge?.challenge_uid, user_uid: nil, success: { (result) -> Void in
//            SVProgressHUD.dismiss()
//            let model = result as! ModelVideoList
//            if self.pageNo == 0 {
//                self.videoList.removeAll()
//            }
//
//            self.isLast = model.is_last
//
//            for i in 0 ..< model.list.count {
//                self.videoList.append(model.list[i]!)
//            }
//
//            self.tvChallenge.reloadData()
//            self.refreshControl.endRefreshing()
//        }, failure: { (_, err) -> Void in
//            SVProgressHUD.dismiss()
//            self.view.showToast(err)
//        })
//    }
//}
