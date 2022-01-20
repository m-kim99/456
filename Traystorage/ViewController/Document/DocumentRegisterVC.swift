import UIKit
import SKPhotoBrowser

class DocumentRegisterVC: BaseVC {
    
    @IBOutlet weak var imageDocment: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfTag: UITextField!
    
    @IBOutlet weak var tfDetail: UITextView!
    @IBOutlet weak var lblDetailPlaceHolder: UILabel!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    @IBOutlet weak var hideKeyboardGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var btnAddImageMain: UIButton!
    @IBOutlet weak var btnAddImageSub: UIButton!
    
    var document: ModelDocument = ModelDocument()
    
    let viewTagImageCollectionView = 1
    let viewTagTagCollectionView = 2
    let viewTagLabelCollectionView = 3
    
    let viewTagStartImage = 1000
    let viewTagStartTag = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.register(UINib(nibName: "item_image", bundle: nil), forCellWithReuseIdentifier: "cell")
        tagCollectionView.register(UINib(nibName: "item_tag", bundle: nil), forCellWithReuseIdentifier: "cell")
        labelCollectionView.register(UINib(nibName: "item_label", bundle: nil), forCellWithReuseIdentifier: "cell")
        
//        tagListView.set
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = false
        
        for i in 1...10 {
            document.tags.append("tag" + i.description)
        }
        
        let image = UIImage(named: "Group 32")!
        for _ in 1...3 {
            document.images.append(image)
        }
        
        updateImageAddButtonAndCollectionView()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickBG(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        popVC()
    }
    
    private var imgPicker: UIImagePickerController! = nil
    @IBAction func onClickAddImage(_ sender: Any) {
//        var images = [SKPhoto]()
//        var photo = SKPhoto.photoWithImage(UIImage(named: "ic_back")!)// add some UIImage
//        images.append(photo)
//        photo = SKPhoto.photoWithImage(UIImage(named: "Icon-C-Plus-White-16")!)
//        images.append(photo)
//        let browser = SKPhotoBrowser(photos: images)
//        browser.initializePageIndex(0)
//        present(browser, animated: true, completion: {})
        imgPicker.sourceType = .photoLibrary
        
        imgPicker.mediaTypes = ["public.image"]
        present(imgPicker, animated: false, completion: nil)
        
    }
    
    @IBAction func onClickAddTag(_ sender: Any) {
        if let tagText = tfTag.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !tagText.isEmpty {
            document.tags.append(tagText)
            tagCollectionView.reloadData()
            tfTag.text = nil
        }
    }
    
    
    private func hideKeyboard() {
        tfTitle.resignFirstResponder()
        tfTag.resignFirstResponder()
        tfDetail.resignFirstResponder()
    }
    
    
    override func keyboardWasShown(_ aNotification: Notification) {
        super.keyboardWasShown(aNotification)
        hideKeyboardGesture.isEnabled = true
    }
    
    override func keyboardWillBeHidden(_ aNotification: Notification) {
        super.keyboardWillBeHidden(aNotification)
        hideKeyboardGesture.isEnabled = false
    }
    
    private func updateDetailPlaceHolderVisible(_ detail: String) {
        lblDetailPlaceHolder.isHidden = !detail.isEmpty
    }
    
    private func updateImageAddButtonAndCollectionView() {
        let noImage = document.images.isEmpty
        btnAddImageMain.isHidden = !noImage
        btnAddImageSub.isHidden = noImage
        imageCollectionView.isHidden = noImage
    }
    
    @IBAction func onClickClose(_ sender: UIButton) {
        guard let superView = sender.superview else {
            return
        }
        
        let viewTag = superView.tag
        
        
        if viewTag >= viewTagStartTag {
            let index = viewTag - viewTagStartTag
            document.tags.remove(at: index)
            tagCollectionView.reloadData()
        } else {
            let index = viewTag - viewTagStartImage
            document.images.remove(at: index)
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
        switch collectionViewTag {
        case viewTagImageCollectionView:
            return document.images.count
        case viewTagTagCollectionView:
            return document.tags.count
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
        case viewTagLabelCollectionView:
            if let outLineView = cell.viewWithTag(20) {
                outLineView.borderWidth = document.label == indexPath.row ? 1 : 0
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
            closeButton.removeTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
            closeButton.addTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewTag = collectionView.tag
        
        switch collectionViewTag {
        case viewTagImageCollectionView:
            
            break
        case viewTagTagCollectionView:
            break
        case viewTagLabelCollectionView:
            document.label = indexPath.row
            labelCollectionView.reloadData()
            break
        default:
            break
        }
    }
    
}


extension DocumentRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerControllerDidCancel(picker)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: false) { [weak self] () -> Void in
                self?.document.images.append(image)
                self?.imageCollectionView.reloadData()
                self?.updateImageAddButtonAndCollectionView()
            }
        }
    }
}
