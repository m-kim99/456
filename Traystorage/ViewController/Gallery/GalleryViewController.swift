//
//  GalleryViewController.swift
//  As_User
//
//  Created by Snow on 11/06/2019.
//  Copyright © 2019 Snow. All rights reserved.
//

import UIKit
import Photos

class galleryList: NSObject {
    var image: UIImage!
    var select: Bool!
}

class GalleryViewController: BaseVC {
    @IBOutlet weak var clvImage: UICollectionView!
    
    var multi = 1
    var count = 4
    
    var imgList = [galleryList]()
    var selectedImgList = [UIImage]()
    var nSelect : Int = -1
    var assetsList = [PHAsset]()
    
    var m_bVideo = false
    
    var mMedias = [PHAsset]()
    var fetchResult: PHFetchResult<AnyObject>!
    let imageManager = PHCachingImageManager()
    
    var thumbnailSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }

    func initUI() {
        clvImage.register(UINib.init(nibName: "cvc_gallery_image_list", bundle: nil), forCellWithReuseIdentifier: "ImageListCVC")
        checkPermission()
    }
    
    func checkPermission() {
        authorize(fromViewController: self) { (authorized) -> Void in
            guard authorized == true else {
                self.showDialog()
                return
            }
            self.m_bVideo ? self.getMedias() : self.initAlbum()
        }
    }
    
    func showDialog() {
        let alert = UIAlertController (title: "권한 요청", message: "해당 기능을 사용하려면 권한이 필요합니다.\n권한을 허용해주세요.", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "취소", style: .cancel) { void in
            self.checkPermission()
        }) //, handler: nil)
        alert.addAction(UIAlertAction(title: "Settings", style: .destructive) { void in
            self.goSetting()
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    func goSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func showList() {
        if assetsList.count <= 0 {
            return
        } else {
            for item in getImageFromAsset(assetsList: assetsList) {
                let temp = galleryList()
                temp.image = item
                temp.select = false
                imgList.append(temp)
            }
        }
        
        clvImage.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = self.view.bounds.width / 3
        thumbnailSize = CGSize(width: width , height: width)
    }
    
    func getMedias() {
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchResult = (PHAsset.fetchAssets(with: allPhotosOptions) as! PHFetchResult<AnyObject>)
        }
        
        for i in 0..<fetchResult.count {
            let asset = fetchResult.object(at: i) as! PHAsset
            
            if asset.mediaType == PHAssetMediaType.video {
                mMedias.append(asset)
            }
        }
        
        let width = 720
        thumbnailSize = CGSize(width: width , height: width)
        
        clvImage.reloadData()
    }
    
    func getImageFromAsset(assetsList : [PHAsset]) -> [UIImage] {
        var resImg = [UIImage]()
        
        let option = PHImageRequestOptions()
        option.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        option.isSynchronous = true
        
        for asset in assetsList {
            let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            
            PHCachingImageManager.default().requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: option) { (result, _) in
                if let image = result {
                    resImg.append(image)
                }
            }
        }
        
        return resImg
    }
    
    func initAlbum() {
        let fetchOptions = PHFetchOptions()
        
        // Camera roll fetch result
        let cameraRollResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions)
        
        // Albums fetch result
        let albumResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        let arrCamera = initAlbumItem(cameraRollResult)
        let arrAlbum = initAlbumItem(albumResult)
        
        for obj in [arrCamera, arrAlbum] {
            for item in obj {
                assetsList.append(item)
            }
        }
        
        showList()
    }
    
    func initAlbumItem(_ fetchResult : PHFetchResult<PHAssetCollection>) -> [PHAsset] {
        var arrAsset = [PHAsset]()
        
        let cachingManager = PHCachingImageManager.default() as? PHCachingImageManager
        cachingManager?.allowsCachingHighQualityImages = false
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        fetchResult.enumerateObjects({ (object, index, stop) -> Void in
            let result = PHAsset.fetchAssets(in: object, options: fetchOptions)
            result.enumerateObjects({ (asset, idx, stp) in
                arrAsset.append(asset)
            })
        })
        
        return arrAsset
    }
    
    func authorize(_ status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(), fromViewController: UIViewController, completion: @escaping (_ authorized: Bool) -> Void) {
        switch status {
        case .authorized:
            // We are authorized. Run block
            completion(true)
            
        case .notDetermined:
            // Ask user for permission
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.authorize(status, fromViewController: fromViewController, completion: completion)
                })
            })
            
        default:
            DispatchQueue.main.async(execute: { () -> Void in
                completion(false)
            })
        }
    }
    
    func popVC() {
        let nav : UINavigationController! = self.navigationController
        var viewVCs : [UIViewController] = nav.viewControllers
        viewVCs.removeLast()
        nav.setViewControllers(viewVCs, animated: true)
    }
    
    
    @IBAction func onClickDone(_ sender: Any) {
        if selectedImgList.count == 0 {
            return
        }
        
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue:"image_pick"), object: selectedImgList))
        popVC()
    }

}

extension GalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 20) / 3, height: (collectionView.bounds.size.width - 4) / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_bVideo ? mMedias.count : imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if m_bVideo {
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue:"video_pick"), object: mMedias[indexPath.row]))
            popVC()
        } else {
            if indexPath.row == 0 { // camera
                AlertDialog.show(self, title: "Camera", message: "Not implement camera")
            } else {
                let row = indexPath.row - 1
                imgList[row].select = !imgList[row].select
                if imgList[row].select {
                    if multi == 1 {
                        if selectedImgList.count < count {
                            selectedImgList.append(imgList[row].image)
                        }
                    } else {
                        selectedImgList.removeAll()
                        selectedImgList.append(imgList[row].image)
                    }
                } else {
                    var ind = -1
                    for i in 0..<selectedImgList.count {
                        if selectedImgList[i] == imgList[row].image {
                            ind = i
                        }
                    }
                    if ind > -1 {
                        selectedImgList.remove(at: ind)
                    }
                }
                
                clvImage.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clvImage.dequeueReusableCell(withReuseIdentifier: "ImageListCVC", for: indexPath) as! ImageListCVC
        
        if m_bVideo {
            var asset: PHAsset = PHAsset()
            asset = mMedias[indexPath.row]
            
            if cell.representedAssetIdentifier != asset.localIdentifier {
                cell.representedAssetIdentifier = asset.localIdentifier
                let imageOptions = PHImageRequestOptions()
                imageOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
                imageOptions.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: PHImageContentMode.aspectFill, options: imageOptions, resultHandler: { image, _ in
                    if cell.representedAssetIdentifier == asset.localIdentifier {
                        cell.imgPhoto.image = image
                    }
                })
            }
            
        } else {
            if indexPath.row == 0 {
                cell.isCameraCell = true
            } else {
                cell.isCameraCell = false
                let row = indexPath.row - 1
                cell.imgPhoto.image = imgList[row].image
                cell.vwEffect.cornerRadius = 12
                
                var ind = -1
                if selectedImgList.count > 0 {
                    for i in 0..<selectedImgList.count {
                        if selectedImgList[i] == imgList[row].image {
                            ind = i
                        }
                    }
                }
                
                cell.selectedIndex = ind
            }
        }
        
        return cell
    }
}
