//
//  FaqTVC.swift
//  Traystorage
//

import UIKit

protocol NoticeTVCDelegate {
    
}

class NoticeTVC: UITableViewCell {
    @IBOutlet weak var vwRoot: UIView!
    @IBOutlet weak var vwIcon: UIImageView!
    @IBOutlet weak var lblTitle: UIFontLabel!
    @IBOutlet weak var lblDate: UIFontLabel!
    
    private var dataModel: ModelPaymentHistoryStadium!
    private var delegate: NoticeTVCDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: ModelPaymentHistoryStadium, delegate: NoticeTVCDelegate) {
        self.dataModel = data
        self.delegate = delegate
    }
    
    //
    // MARK: - Action
    //
}
