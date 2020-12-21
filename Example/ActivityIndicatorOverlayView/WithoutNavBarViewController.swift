//
//  WithoutNavBarViewController.swift
//  ActivityIndicatorOverlayView_Example
//
//  Created by Isuru Nanayakkara on 2020-12-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ActivityIndicatorOverlayView

class WithoutNavBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicatorOverlayView.shared.show()
        setCloseTimer()
    }
    
    @objc func close() {
        ActivityIndicatorOverlayView.shared.hide()
    }
    
    func setCloseTimer() {
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(close), userInfo: nil, repeats: false)
    }
    
    @IBAction func showButtonTapped(_ sender: UIButton) {
        ActivityIndicatorOverlayView.shared.show()
        setCloseTimer()
    }
    
}
