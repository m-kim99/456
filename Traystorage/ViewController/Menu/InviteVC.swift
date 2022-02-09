//
//  InviteVC.swift
//  Traystorage
//

import Foundation

class InviteVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }

    override func removeFromParent() {}

    func initVC() {}

    @IBAction func onClickInvite(_ sender: Any) {
        let appInstallUrl = "http://itunes.apple.com/app/id1608315959?mt=8"
        let content = "문서관리가 필요해?\nTraystorage으로 해결!\n지금 Traystorage을 설치하고 문서를 안전하게 관리해 보세요!"

        // text to share
        let text = content + "\n\n" + appInstallUrl
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
