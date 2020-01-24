//
//  ViewController.swift
//  HolographicAnimation
//
//  Created by Edward O'Neill on 1/19/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backbroundCollections: Set<UIImageView>  = []
    var randomSizeList: [CGFloat] = [20, 30, 40]
    var randomAlpha: [CGFloat] = [0.8, 0.9, 1.0, 1.0]
    var colors: [UIColor] = [.brown, .gray, .green, .white, .orange, .purple]
    var animationTimer: Timer?
    var minHeight: CGFloat = 0
    var currentX: CGFloat = 0
    var counter = 0
    var alphaCount:CGFloat = 0.0
    var reset = UIButton()
    var randomColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let frame = CGRect(x: view.frame.midX - 50, y: view.frame.midY - 25, width: 100, height: 50)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.frame = frame
        button.addTarget(self, action: #selector(reLoadScreen), for: .touchUpInside)
        reset = button
        reset.backgroundColor = .systemBlue
        reset.alpha = 0
        animationTimer = Timer.scheduledTimer(timeInterval: 0.075, target: self, selector: #selector(showButton), userInfo: nil, repeats: true)
        view.addSubview(reset)
    }
    
    @objc func reLoadScreen() {
        alphaCount = 0
        reset.backgroundColor = .clear
        reset.isEnabled = false
        currentX = 0
        minHeight = 0
        randomColor = colors.randomElement()!
        animationTimer = Timer.scheduledTimer(timeInterval: 0.0025, target: self, selector: #selector(loadingScreen), userInfo: nil, repeats: true)
    }
    
    @objc func loadingScreen() {
        let currentY: CGFloat = minHeight
        let randomSize = randomSizeList.randomElement()!
        // print("hello")
        
        let cell = UIImageView(frame: CGRect(x: currentX, y: currentY, width: randomSize, height: randomSize))
        
        cell.backgroundColor = randomColor
        cell.alpha = randomAlpha.randomElement()!
        self.view.addSubview(cell)
        backbroundCollections.insert(cell)
        self.currentX += randomSize
        
        if currentX >= view.frame.maxX {
            self.minHeight += 10
            currentX = 0
        }
        
        if currentY >= view.frame.maxY {
            for cell in backbroundCollections {
                cell.alpha = 1
            }
            animationTimer?.invalidate()
            animationTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(removeCell), userInfo: nil, repeats: true)
//            for cell in backbroundCollections {
//                cell.removeFromSuperview()
//            }
//            backbroundCollections = []
        }
    }
    
    @objc func removeCell() {
        if !backbroundCollections.isEmpty {
            let removedCell = backbroundCollections.removeFirst()
            removedCell.removeFromSuperview()
        } else {
            animationTimer?.invalidate()
            reset.backgroundColor = .systemBlue
            reset.alpha = 0
            view.addSubview(reset)
            animationTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(showButton), userInfo: nil, repeats: true)
        }
    }
    
    @objc func showButton() {
        if alphaCount <= 0.5 {
            alphaCount += 0.025
            reset.alpha = alphaCount
        } else {
            reset.isEnabled = true
            animationTimer?.invalidate()
        }
    }
}


