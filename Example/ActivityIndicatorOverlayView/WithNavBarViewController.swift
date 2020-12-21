//
//  WithNavBarViewController.swift
//  ActivityIndicatorOverlayView_Example
//
//  Created by Isuru Nanayakkara on 2020-12-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ActivityIndicatorOverlayView

class WithNavBarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicatorOverlayView.shared.showProgressView()
        setCloseTimer()
    }
    
    @objc func close() {
        ActivityIndicatorOverlayView.shared.hideProgressView()
    }
    
    func setCloseTimer() {
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(close), userInfo: nil, repeats: false)
    }
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBAction func showButtonTapped(_ sender: UIButton) {
        ActivityIndicatorOverlayView.shared.backgroundColor = UIColor.init(red: CGFloat(redSlider.value/255.0), green: CGFloat(greenSlider.value/255.0), blue: CGFloat(blueSlider.value/255.0), alpha: CGFloat(alphaSlider!.value))
        ActivityIndicatorOverlayView.shared.showProgressView()
        setCloseTimer()
    }
    
    @IBAction func leftButtonTapped(_ sender: UIBarButtonItem) {
        let size = ActivityIndicatorOverlayView.shared.size
        ActivityIndicatorOverlayView.shared.size = CGSize(width: size.width - 5, height: size.height - 5)
    }
    
    @IBAction func rightButtonTapped(_ sender: UIBarButtonItem) {
        let size = ActivityIndicatorOverlayView.shared.size
        ActivityIndicatorOverlayView.shared.size = CGSize(width: size.width + 5, height: size.height + 5)
    }
    
}
