import SVProgressHUD
import UIKit
import PullToRefresh
import ImageSlideshow
import Kingfisher
import SKPhotoBrowser

class DocumentDetailVC: BaseVC {
    
    @IBOutlet weak var lblChallengeName: UILabel!
    
    private var imageList: [UIImage] = []
    private var pageNo = 0
    private var isLast = false
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var tagView: UILabel!
    
    @IBOutlet weak var documentTitle: UILabel!
    @IBOutlet weak var documentContent: UILabel!
    @IBOutlet weak var documentDate: UILabel!
    @IBOutlet weak var documentLabel: UIView!
    
    
    let viewTagImageCollectionView = 1
    let viewTagTagCollectionView = 2
    
    var isAppearFromAddDoc = false
    var isUpdated = false
    
    private var refreshControl = UIRefreshControl()
    
    var document: ModelDocument?
    
    var photoBrowser: SKPhotoBrowser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAppearFromAddDoc {
            self.view.showToast("doc_add_success_toast"._localized)
        }
        
        loadContentsFormDoc()

//        initVC()
//        initPullToRefresh()
//        loadChallengeDetail(challenge?.challenge_uid)
        
        imageCollectionView.register(UINib(nibName: "item_image", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    private func loadContentsFormDoc() {
        if let document = document {
            documentTitle.text = document.title
            documentContent.text = document.content
            documentDate.text = document.reg_time
            documentLabel.backgroundColor = AppColor.labelColors[document.label]
            if document.tags.isEmpty {
                tagView.text = nil
            } else {
                tagView.text = "#" + document.tags.joined(separator: " #")
            }

        } else {
            documentTitle.text = nil
            documentContent.text = nil
            documentDate.text = nil
            documentLabel.backgroundColor = nil
            tagView.text = nil
        }
        
        imageCollectionView.reloadData()
    }
    
    override func onBackProcess(_ viewController: UIViewController) {
        guard let vcs = self.navigationController?.viewControllers else {
            return
        }
        
        for vc in vcs {
            if vc is MainVC {
                if isUpdated, let mainVC = vc as? MainVC {
                    mainVC.onWillBack("update", document?.doc_id)
                }
                
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }

    //

    // MARK: - ACTION

    //
    @IBAction func onClickTrash(_ sender: Any) {
        let docID = self.document?.doc_id
        ConfirmDialog.show2(self, title: "doc_del_query_title"._localized, message: "doc_del_query_desc"._localized, showCancelBtn: true) { [weak self]() -> Void in
            self?.deleteDocument(docID)
        }
    }

    @IBAction func onClickEdit(_ sender: Any) {
        let editVC = DocumentRegisterVC(nibName: "vc_document_register", bundle: nil)
        editVC.document = self.document
        editVC.popDelegate = self
        pushVC(editVC, animated: true, params: self.params)
    }
    
    @IBAction func onClickNFCRegister(_ sender: Any) {
        pushVC(DocumentNFCRegisterVC(nibName: "vc_document_nfc_register", bundle: nil), animated: true, params: params as [String : Any])
    }
}

//

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate


extension DocumentDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let doc = document else {
            return 0
        }
        return doc.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let closeButton = cell.viewWithTag(10) as? UIButton {
            closeButton.removeFromSuperview()
        }

        if let contentView = cell.viewWithTag(5) {
            contentView.backgroundColor = UIColor.clear
        }
        
        let index = indexPath.row
        
        let document = self.document!
        
        if let imageView = cell.viewWithTag(2) as? UIImageView {
            document.setToImageView(at: index, imageView: imageView)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = ImageSlideViewVC(nibName: "vc_image_browser", bundle: nil)
//        vc.modelDocument = self.document!
//        self.navigationController?.pushViewController(vc, animated: true)
        
        SKPhotoBrowserOptions.swapCloseAndDeleteButtons = true
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayCounterLabel = true
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        SKButtonOptions.closeButtonPadding.y = self.view.safeAreaInsets.top
        SKToolbarOptions.font = AppFont.appleGothicNeoRegular(15)
        
        let modelDocument = self.document!
        
        var images = [SKPhoto]()
        for item in modelDocument.images {
            if let url = item["url"] as? String {
                images.append(SKPhoto.photoWithImageURL(url))
            } else if let image = item["image"] as? UIImage {
                images.append(SKPhoto.photoWithImage(image))
            }
        }

        photoBrowser = SKPhotoBrowser(photos: images)
        photoBrowser.delegate = self
        self.navigationController?.pushViewController(photoBrowser, animated: true)
    }
}

extension DocumentDetailVC : SKPhotoBrowserDelegate {
    func didDismissAtPageIndex(_ index: Int) {
        popVC()
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
extension DocumentDetailVC: BaseRestApi {
    func loadDocumentDetail(_ document_uid: Int!) {
        LoadingDialog.show()
        Rest.documentDetail(documentID: document_uid, success: { [weak self] (result) -> Void in
            LoadingDialog.dismiss()
            self?.document = (result as! ModelDocument)
            self?.loadContentsFormDoc()
        }) { [weak self](_, err) -> Void in
            LoadingDialog.dismiss()
            self?.view.showToast(err)
        }
    }
    
    func deleteDocument(_ docID: Int!) {
        LoadingDialog.show()
        Rest.documentDelete(id: docID.description, success: { [weak self] (result) -> Void in
            LoadingDialog.dismiss()
            if let popDelegate = self?.popDelegate {
                popDelegate.onWillBack("delete", docID)
            }
            self?.popVC()
        }, failure: { (_, err) -> Void in
            LoadingDialog.dismiss()
            self.view.showToast(err)
        })
    }

//    func loadVideoList(page: Int) {
//        if (!refreshControl.isRefreshing) {
//            LoadingDialog.show()
//        }
//
//        self.pageNo = page
//        Rest.videoList(page: page, challenge_uid: challenge?.challenge_uid, user_uid: nil, success: { (result) -> Void in
//            LoadingDialog.dismiss()
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
//            LoadingDialog.dismiss()
//            self.view.showToast(err)
//        })
//    }
}

extension DocumentDetailVC: PopViewControllerDelegate
{
    func onWillBack(_ sender: String, _ result: Any?) {
        if sender == "update" {
            loadContentsFormDoc()
            isUpdated = true
        }
    }
}
