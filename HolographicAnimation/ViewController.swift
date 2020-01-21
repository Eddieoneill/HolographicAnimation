//
//  ViewController.swift
//  HolographicAnimation
//
//  Created by Edward O'Neill on 1/19/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backbroundCollections = [UIImageView]()
    var randomSizeList: [CGFloat] = [20, 30, 40]
    var randomAlpha: [CGFloat] = [0.8, 0.9, 1.0, 1.0]
    var animationTimer: Timer?
    var minHeight: CGFloat = 0
    var currentX: CGFloat = 0
    var counter = 0
    var alphaCount:CGFloat = 0.0
    var reset = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.midX)
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
    
    @objc func run() {
        loadingScreen()
    }
    
    @objc func reLoadScreen() {
        alphaCount = 0
        reset.backgroundColor = .clear
        reset.isEnabled = false
        counter += 1
        currentX = 0
        minHeight = 0
        animationTimer = Timer.scheduledTimer(timeInterval: 0.0025, target: self, selector: #selector(loadingScreen), userInfo: nil, repeats: true)
    }
    
    @objc func loadingScreen() {
        let currentY: CGFloat = minHeight
        let randomSize = randomSizeList.randomElement()!
        // print("hello")
        
        let cell = UIImageView(frame: CGRect(x: currentX, y: currentY, width: randomSize, height: randomSize))
        
        
        if counter % 2 == 0 {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .black
        }
        cell.alpha = randomAlpha.randomElement()!
        self.view.addSubview(cell)
        backbroundCollections.append(cell)
        self.currentX += randomSize
        
        if currentX >= view.frame.maxX {
            self.minHeight += 10
            currentX = 0
        }
        
        if currentY >= view.frame.maxY {
            for cell in backbroundCollections {
                cell.alpha = 1
            }
            reset.isEnabled = true
            reset.backgroundColor = .systemBlue
            reset.alpha = 0
            animationTimer?.invalidate()
            print("hello")
            view.addSubview(reset)
            animationTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(showButton), userInfo: nil, repeats: true)
            backbroundCollections = []
        }
    }
    
    @objc func showButton() {
        if alphaCount <= 0.5 {
            alphaCount += 0.025
            reset.alpha = alphaCount
        } else {
            animationTimer?.invalidate()
        }
    }
}

