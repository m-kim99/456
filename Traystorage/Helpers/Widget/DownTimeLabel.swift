//
//  DownTimeLabel.swift
//  Traystorage
//
//

import Foundation
import UIKit

@IBDesignable
class DownTimeLabel: UIFontLabel {
    @IBInspectable var startDownTime: Int = 180 {
        didSet {
            countDownTime = startDownTime
        }
    }
    
    var countDownTimer:  Timer?
    var countDownTime = 0
    
    func startCountDownTimer() {
        stopTimer()
        self.countDownTime = startDownTime
        updateCountDownLabelText()
        self.isHidden = false;
        
        let countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
            
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.countDownTime -= 1
            
            if weakSelf.countDownTime <= 0 {
                timer.invalidate()
            }
            
            weakSelf.updateCountDownLabelText()
        })
        
        self.countDownTimer = countDownTimer
    }
    
    func onCountDown(_ sender: Any) {
        
    }
    
    private func stopTimer() {
        if let oldTimer = self.countDownTimer {
            oldTimer.invalidate()
        }
    }
    
    private func updateCountDownLabelText() {
        let formatter = DateComponentsFormatter()
        self.text = formatter.string(from: TimeInterval(self.countDownTime))
    }
}
