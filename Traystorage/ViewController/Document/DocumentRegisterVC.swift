import UIKit
import SKPhotoBrowser
import SVProgressHUD

class DocumentRegisterVC: BaseVC {
    
    @IBOutlet weak var imageDocment: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfTag: UITextField!
    
    @IBOutlet weak var tfDetail: UITextView!
    @IBOutlet weak var lblDetailPlaceHolder: UILabel!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    @IBOutlet weak var btnAddImageMain: UIButton!
    @IBOutlet weak var btnAddImageSub: UIButton!
    
    var isNewDocument = false
    
    var newDocument = ModelDocument()
    var document: ModelDocument?
    
    let viewTagImageCollectionView = 1
    let viewTagTagCollectionView = 2
    let viewTagLabelCollectionView = 3
    
    let viewTagStartImage = 1000
    let viewTagStartTag = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyDocument(toOrigin: false)
        initVC()
    }
    
    private func initVC() {
        imageCollectionView.register(UINib(nibName: "item_image", bundle: nil), forCellWithReuseIdentifier: "cell")
        tagCollectionView.register(UINib(nibName: "item_tag", bundle: nil), forCellWithReuseIdentifier: "cell")
        labelCollectionView.register(UINib(nibName: "item_label", bundle: nil), forCellWithReuseIdentifier: "cell")
        NotificationCenter.default.addObserver(self, selector: #selector(imgPick(_:)), name: NSNotification.Name(rawValue: "image_pick"), object: nil)
        
        updateImageAddButtonAndCollectionView()
        
        tfTitle.text = newDocument.title
        tfDetail.text = newDocument.content
        updateDetailPlaceHolderVisible(newDocument.content)
    }
    
    private func copyDocument(toOrigin: Bool) {
        guard let origDoc = document else {
            return
        }
        
        let newDoc = newDocument

        if toOrigin {
            origDoc.title = newDoc.title
            origDoc.content = newDoc.content
            origDoc.label = newDoc.label
            
            origDoc.tags.replaceSubrange(0..<origDoc.tags.count, with: newDoc.tags)
            origDoc.images.replaceSubrange(0..<origDoc.images.count, with: newDoc.images)
            origDoc.imagesUrlList.replaceSubrange(0..<origDoc.imagesUrlList.count, with: newDoc.imagesUrlList)
        } else {
            newDoc.doc_id = origDoc.doc_id
            newDoc.user_id = origDoc.user_id
            newDoc.title = origDoc.title
            newDoc.content = origDoc.content
            newDoc.label = origDoc.label
            
            newDoc.tags.replaceSubrange(0..<newDoc.tags.count, with: origDoc.tags)
            newDoc.images.replaceSubrange(0..<newDoc.images.count, with: origDoc.images)
            newDoc.imagesUrlList.replaceSubrange(0..<newDoc.imagesUrlList.count, with: origDoc.imagesUrlList)
        }
    }

    @IBAction func onClickRegister(_ sender: Any) {
        guard let title = tfTitle.text, !title.isEmpty else {
            self.view.showToast("doc_title_empty"._localized)
            return
        }
        
        guard let content = tfDetail.text, !content.isEmpty else {
            self.view.showToast("doc_content_empty"._localized)
            return
        }
        
        let doc = newDocument
        
        let tags = doc.tags.joined(separator: ",")
        
        var imageURLs: [String] = []
        for url in doc.imagesUrlList {
            if url != nil {
                imageURLs.append(url!)
            }
        }
        
        let images = imageURLs.joined(separator: ",")
        
        documentEditDown(title: title, content: content, lable: doc.label, tags: tags, images: images)
    }

    @IBAction func onClickAddImage(_ sender: Any) {
        let vc = GalleryViewController(nibName: "vc_gallery", bundle: nil)
        self.pushVC(vc, animated: true)
    }
    
    @IBAction func onClickAddTag(_ sender: Any) {
        guard let tagText = tfTag.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !tagText.isEmpty else {
            self.view.showToast("doc_tag_empty"._localized)
            return
        }
        
        let doc = newDocument
        
        if doc.tags.count < 5 {
            if doc.tags.contains(tagText) {
                self.view.showToast("doc_duplicated_tag"._localized)
            } else {
                doc.tags.insert(tagText, at: 0)
                tagCollectionView.reloadData()
                tfTag.text = nil
            }
        } else {
            self.view.showToast("doc_tag_limit_5"._localized)
        }
    }
    
    
    override func hideKeyboard() {
        tfTitle.resignFirstResponder()
        tfTag.resignFirstResponder()
        tfDetail.resignFirstResponder()
    }
    
    private func updateDetailPlaceHolderVisible(_ detail: String) {
        lblDetailPlaceHolder.isHidden = !detail.isEmpty
    }
    
    @objc func imgPick(_ notification : Notification) {
        let imgList = notification.object as! [UIImage]
        
        for image in imgList {
            newDocument.addImage(image: image)
        }
        self.imageCollectionView.reloadData()
        self.updateImageAddButtonAndCollectionView()
    }
    
    private func updateImageAddButtonAndCollectionView() {
        let noImage = newDocument.images.isEmpty
        btnAddImageMain.isHidden = !noImage
        btnAddImageSub.isHidden = noImage
        imageCollectionView.isHidden = noImage
    }
    
    private func documentEditDown(title: String, content: String, lable: Int, tags: String, images: String) {
        SVProgressHUD.show()
        
        let doc = newDocument
        
        if isNewDocument {
            Rest.documentInsert(title: title, content: content, label: doc.label, tags: tags, images: images) { [weak self](result) in

                if let popDelegate = self?.popDelegate {
                    popDelegate.onWillBack("insert", result!)
                }
                
                self?.popVC()
            } failure: { [weak self](_, err) in
                SVProgressHUD.dismiss()
                self?.view.showToast(err)
            }
        } else {
            Rest.documentUpdate(id: doc.doc_id.description, title: title, content: content, label: lable, tags: tags, images: images, success: { [weak self] (result) in
                
                if let popDelegate = self?.popDelegate {
                    doc.title = title
                    doc.content = content
                    doc.label = lable
                    doc.tags.removeAll()
                    
                    let tagList = tags.split(separator: ",")
                    for tag in tagList {
                        doc.tags.append(tag.description)
                    }
                    
                    self?.copyDocument(toOrigin: true)
                    popDelegate.onWillBack("update", doc)
                }
                self?.popVC()
                
            }) {[weak self](_, err) in
                SVProgressHUD.dismiss()
                self?.view.showToast(err)
            }
        }
    }
    
    @IBAction func onClickClear(_ sender: UIButton) {
        guard let superView = sender.superview else {
            return
        }
        
        let viewTag = superView.tag
        let doc = newDocument
        if viewTag >= viewTagStartTag {
            let index = viewTag - viewTagStartTag
            doc.tags.remove(at: index)
            tagCollectionView.reloadData()
            
            self.view.showToast(index.description + " - tag was deleted.")
        } else {
            let index = viewTag - viewTagStartImage
            doc.removeImage(at: index)
            imageCollectionView.reloadData()
            
            updateImageAddButtonAndCollectionView()
        }
    }
}

extension DocumentRegisterVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateDetailPlaceHolderVisible(textView.text ?? "")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLen = (textView.text?.count ?? 0) - range.length + text.count
        return newLen <= 200
    }
}

extension DocumentRegisterVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLen = (textField.text?.count ?? 0) - range.length + string.count

        if textField == tfTitle, newLen > 30 {
            return false
        }
        if textField == tfTag, newLen > 10 {
            return false
        }
        

        return true
    }
}


extension DocumentRegisterVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewTag = collectionView.tag
        let doc = newDocument
        switch collectionViewTag {
        case viewTagImageCollectionView:
            return doc.images.count
        case viewTagTagCollectionView:
            return doc.tags.count
        case viewTagLabelCollectionView:
            return 10
        default:
            break
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let collectionViewTag = collectionView.tag
        let doc = newDocument
        let index = indexPath.row
        switch collectionViewTag {
        case viewTagImageCollectionView:
            if let imageView = cell.viewWithTag(2) as? UIImageView {
                if let url = doc.imagesUrlList[index] {
                    imageView.kf.setImage(with: URL(string: url))
                } else {
                    imageView.image = doc.images[index]
                }
            }
            break
        case viewTagTagCollectionView:
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = "#" + doc.tags[indexPath.row]
            }
            break
        case viewTagLabelCollectionView:
            if let outLineView = cell.viewWithTag(20) {
                outLineView.borderWidth = doc.label == indexPath.row ? 1 : 0
            }
            
            if let labelColorView = cell.viewWithTag(21) {
                labelColorView.backgroundColor = AppColor.labelColors[indexPath.row]
            }
            break
        default:
            break
        }
        
        if let closeButton = cell.viewWithTag(10) as? UIButton {
            if let contentView = closeButton.superview {
                let newTagStart = collectionViewTag == viewTagImageCollectionView ? viewTagStartImage : viewTagStartTag
                contentView.tag = newTagStart + indexPath.row
            }
            closeButton.removeTarget(self, action: #selector(self.onClickClear(_:)), for: .touchUpInside)
            closeButton.addTarget(self, action: #selector(self.onClickClear(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewTag = collectionView.tag
        let doc = newDocument
        switch collectionViewTag {
        case viewTagImageCollectionView:
            
            break
        case viewTagTagCollectionView:
            break
        case viewTagLabelCollectionView:
            doc.label = indexPath.row
            labelCollectionView.reloadData()
            break
        default:
            break
        }
    }
}
