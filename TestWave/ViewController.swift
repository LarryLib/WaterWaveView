//
//  ViewController.swift
//  TestWave
//
//  Created by larry on 2018/11/17.
//  Copyright © 2018 twofly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let wave = WaterWaveView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 300))
        wave.setColor(bgColor: .red, fillColor: .blue)
        wave.drawWaterWavePath(percent: 0.50)
        view.addSubview(wave)
    }
}

