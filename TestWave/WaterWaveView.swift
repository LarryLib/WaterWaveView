//
//  WaterWaveView.swift
//  TestWave
//
//  Created by larry on 2018/11/17.
//  Copyright © 2018 twofly. All rights reserved.
//

import UIKit

class WaterWaveView: UIView {
    
    private var displayLink: CADisplayLink!
    private lazy var waveLayer: CAShapeLayer! = {
        let shapeLayper = CAShapeLayer()
        layer.addSublayer(shapeLayper)
        shapeLayper.fillColor = fillColor.cgColor
        return shapeLayper
    }()
    private var percent: CGFloat = 0
    
    private let zoomY: CGFloat = 5            // 波纹振幅 A
    private var translateX: CGFloat = 0         // 波浪水平位移 Φ
    private var currentWavePointY: CGFloat = 0  // 波浪当前的高度 k
    
    private var bgColor = UIColor.red
    private var fillColor = UIColor.blue

    func setColor(bgColor: UIColor, fillColor: UIColor) {
        self.bgColor = bgColor
        self.fillColor = fillColor
    }
    
    func drawWaterWavePath(percent: CGFloat) {
        self.percent = percent
        backgroundColor = bgColor
        currentWavePointY = frame.height
        
        if displayLink != nil {
            displayLink.invalidate()
            displayLink = nil
        }
        displayLink = CADisplayLink(target: self, selector: #selector(setCurrentWaterWaveLayerPath))
        displayLink.add(to: .main, forMode: .common)
    }
    
    @objc private func setCurrentWaterWaveLayerPath() {
        translateX += 0.01
        if currentWavePointY > frame.height * (1 - percent) {
            currentWavePointY -= 2.0
        }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: currentWavePointY))
        var x: Double = 0
        var y: Double = 0
        while x < Double(frame.width) {
            y = Double(zoomY) * sin((Double(x) / Double(180) * Double.pi - Double(5) * Double(translateX) / Double.pi) * Double(2.5)) + Double(currentWavePointY)
            path.addLine(to: CGPoint(x: x, y: y))
            x += 1
        }
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: currentWavePointY))
        path.close()
        waveLayer.path = path.cgPath
    }
}
