//
//  ViewController.swift
//  ProgromaticConstraints
//
//  Created by Jacob Metcalf on 3/13/18.
//  Copyright © 2018 JfMetcalf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topLeftButton = UIButton()
    var topRightButton = UIButton()
    var bottomLeftButton = UIButton()
    var bottomRightButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpButtonConstraints()
    }
    
    // Adding subviews
    func setUpButtons() {
        topLeftButton.backgroundColor = .red
        topRightButton.backgroundColor = .blue
        bottomLeftButton.backgroundColor = .cyan
        bottomRightButton.backgroundColor = .green
        
        // Adding targets
        topLeftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bottomRightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Add targets for exit
        topLeftButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        topRightButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        bottomLeftButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        bottomRightButton.addTarget(self, action: #selector(buttonExited(_:)), for: .touchDragExit)
        
        // Add the buttons as subviews of the VC's view
        view.addSubview(topLeftButton)
        view.addSubview(topRightButton)
        view.addSubview(bottomLeftButton)
        view.addSubview(bottomRightButton)
    }
    
    // Setting up each button's constraints
    func setUpButtonConstraints() {
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Height and Width constraints
        let topButtonWidths = NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: topRightButton, attribute: .width, multiplier: 1, constant: 0)
        let leftButtonHeights = NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: bottomLeftButton, attribute: .height, multiplier: 1, constant: 0)
        let bottomButtonWidths = NSLayoutConstraint(item: bottomLeftButton, attribute: .width, relatedBy: .equal, toItem: bottomRightButton, attribute: .width, multiplier: 1
            , constant: 0)
        let rightButtonHeights = NSLayoutConstraint(item: topRightButton, attribute: .height, relatedBy: .equal, toItem: bottomRightButton, attribute: .height, multiplier: 1, constant: 0)
        
        view.addConstraints([topButtonWidths, leftButtonHeights, bottomButtonWidths, rightButtonHeights])
        
        // Top left constraints
        let topLeftLeading = NSLayoutConstraint(item: topLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let topLeftTop = NSLayoutConstraint(item: topLeftButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let topLeftTrailing = NSLayoutConstraint(item: topLeftButton, attribute: .trailing, relatedBy: .equal, toItem: topRightButton, attribute: .leading, multiplier: 1, constant: 0)
        let topLeftBottom = NSLayoutConstraint(item: topLeftButton, attribute: .bottom, relatedBy: .equal, toItem: bottomLeftButton, attribute: .top, multiplier: 1, constant: 0)
        
        view.addConstraints([topLeftLeading, topLeftTop, topLeftTrailing, topLeftBottom])
        
        
        // Top right constraints
        let topRightTrailing  = NSLayoutConstraint(item: topRightButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let topRightTop = NSLayoutConstraint(item: topRightButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let topRightBottom = NSLayoutConstraint(item: topRightButton, attribute: .bottom, relatedBy: .equal, toItem: bottomRightButton, attribute: .top, multiplier: 1, constant: 0)
        
        view.addConstraints([topRightTrailing, topRightTop, topRightBottom])
        
        //Bottom left constraints
        let bottomLeftLeading = NSLayoutConstraint(item: bottomLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let bottomLeftTrailing = NSLayoutConstraint(item: bottomLeftButton, attribute: .trailing, relatedBy: .equal, toItem: bottomRightButton, attribute: .leading, multiplier: 1, constant: 0)
        let bottomLeftBottom = NSLayoutConstraint(item: bottomLeftButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([bottomLeftLeading, bottomLeftTrailing, bottomLeftBottom])
        
        // Bottom right constraints
        let bottomRightTrailing = NSLayoutConstraint(item: bottomRightButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomRightBottom = NSLayoutConstraint(item: bottomRightButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([bottomRightTrailing, bottomRightBottom])
    }
    
    // Adding targets (actions) for the buttons
    @objc func buttonTapped() {
        // This is like our action
        let topLeftColor = topLeftButton.backgroundColor
        let topRightColor = topRightButton.backgroundColor
        let bottomLeftColor = bottomLeftButton.backgroundColor
        let bottomRightColor = bottomRightButton.backgroundColor
        
        UIView.animate(withDuration: 0.5) {
            self.topRightButton.backgroundColor = topLeftColor
            self.bottomLeftButton.backgroundColor = topRightColor
            self.bottomRightButton.backgroundColor = bottomLeftColor
            self.topLeftButton.backgroundColor = bottomRightColor
        }
    }
    
    // Adding animation
    @objc func buttonExited(_ sender: UIButton) {
        view.bringSubview(toFront: sender)
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [ sender.frame.origin.x + sender.frame.width / 2,
                            sender.frame.origin.x + sender.frame.width / 2 - 15,
                            sender.frame.origin.x = sender.frame.width / 2,
                            sender.frame.origin.x = sender.frame.width / 2 - 15,
                            sender.frame.origin.x = sender.frame.width / 2 ]
        
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 5
        animation.repeatCount = 5
        
        sender.layer.add(animation, forKey: "shake")
    }
    
}

