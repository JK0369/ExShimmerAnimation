//
//  UIView+Extension.swift
//  ExShimmerAnimationView
//
//  Created by Jake.K on 2022/03/31.
//

import UIKit

extension UIView {
  func startAnimationSome() {
    let duration = 1.3
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.colors = [
      UIColor.clear.cgColor,
      UIColor.white.withAlphaComponent(0.3).cgColor,
      UIColor.clear.cgColor
    ]
    gradientLayer.locations = [0.0, 1.0]
    self.layer.addSublayer(gradientLayer)
    
    let shimmerAnimation = CABasicAnimation(keyPath: "locations")
    shimmerAnimation.fromValue = [-0.5, -0.2, 0.0]
    shimmerAnimation.toValue = [1.0, 1.2, 1.4]
//    shimmerAnimation.repeatDuration = .infinity
    shimmerAnimation.repeatCount = 1
    shimmerAnimation.duration = duration
    shimmerAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
    
    gradientLayer.add(shimmerAnimation, forKey: shimmerAnimation.keyPath)
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      self.layer.removeAnimation(forKey: "locations")
      gradientLayer.removeFromSuperlayer()
    }
  }
}
