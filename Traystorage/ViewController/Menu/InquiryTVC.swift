//
//  FaqTVC.swift
//  Traystorage
//

import UIKit

protocol InquiryTVCDelegate {
    
}

class InquiryTVC: UITableViewCell {
    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var vwType: UIView!
    @IBOutlet weak var lblType: UIFontLabel!
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblDate: UIFontLabel!
    @IBOutlet weak var lblDetail: UIFontLabel!
    @IBOutlet weak var btnExpand: UIButton!
    
    private var dataModel: ModelPaymentHistoryStadium!
    private var delegate: InquiryTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: ModelPaymentHistoryStadium, delegate: InquiryTVCDelegate) {
        self.dataModel = data
        self.delegate = delegate
    }
    
    //
    // MARK: - Action
    //
    
    @IBAction func onClickExpand(_ sender: Any) {
        
    }
}
