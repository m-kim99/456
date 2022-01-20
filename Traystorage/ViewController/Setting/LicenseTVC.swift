//
//  FaqTVC.swift
//  Traystorage
//

import UIKit

protocol LicenseTVCDelegate {
    
}

class LicenseTVC: UITableViewCell {
    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblLink: UIFontLabel!
    @IBOutlet weak var lblSubTitle: UIFontLabel!
    
    private var dataModel: ModelPaymentHistoryStadium!
    private var delegate: LicenseTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: ModelPaymentHistoryStadium, delegate: LicenseTVCDelegate) {
        self.dataModel = data
        self.delegate = delegate
    }
    
    //
    // MARK: - Action
    //
}
