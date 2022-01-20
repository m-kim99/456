//
//  FaqTVC.swift
//  Traystorage
//

import UIKit

protocol FaqTVCDelegate {
    func onClickCell(_ model: ModelPaymentHistoryStadium)
}

class FaqTVC: UITableViewCell {
    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var lblSubTitle: UIFontLabel!
    
    private var dataModel: ModelPaymentHistoryStadium!
    private var delegate: FaqTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: ModelPaymentHistoryStadium, delegate: FaqTVCDelegate) {
        self.dataModel = data
        self.delegate = delegate

        self.lblSubTitle.isHidden = true
    }
    
    //
    // MARK: - Action
    //
    @IBAction func onExpand(_ sender: Any) {
        
        self.lblSubTitle.isHidden = false
        self.lblSubTitle.text = "abc"
    }
}
