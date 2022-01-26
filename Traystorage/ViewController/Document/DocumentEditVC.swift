import UIKit

class DocumentEditVC: BaseVC {
    
    @IBOutlet weak var imageDocment: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfTag: UITextField!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
//    @IBOutlet weak var tagListView: RKTagsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.register(UINib(nibName: "item_image", bundle: nil), forCellWithReuseIdentifier: "cell")
        
//        tagListView.set
    }

    
    @IBAction func onClickRegister(_ sender: Any) {
        popVC()
    }
    
    @IBAction func onClickAddImage(_ sender: Any) {
    }
    
    @IBAction func onClickAddTag(_ sender: Any) {
        
        
    }
    
    
    override func hideKeyboard() {
        tfTitle.resignFirstResponder()
        tfTag.resignFirstResponder()
    }
}

extension DocumentEditVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
