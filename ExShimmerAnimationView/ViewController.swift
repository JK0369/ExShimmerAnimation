//
//  ViewController.swift
//  ExShimmerAnimationView
//
//  Created by Jake.K on 2022/03/31.
//

import UIKit

class ViewController: UIViewController {
  let shimmerAnimation = CABasicAnimation(keyPath: "locations")
  let animationGroup = CAAnimationGroup()
  let duration = 2.0
  
  private lazy var sampleButton: UIButton = {
    let button = UIButton()
    button.setTitle("sampleButton", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.backgroundColor = .gray
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  private lazy var sampleView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 27
    view.layer.cornerCurve = .continuous
    view.clipsToBounds = true
    self.view.addSubview(view)
    return view
  }()
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "right")
    view.translatesAutoresizingMaskIntoConstraints = false
    self.sampleView.addSubview(view)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NSLayoutConstraint.activate([
      self.sampleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.sampleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.sampleView.widthAnchor.constraint(equalToConstant: 309),
      self.sampleView.heightAnchor.constraint(equalToConstant: 54),
      
      self.imageView.rightAnchor.constraint(equalTo: self.sampleView.leftAnchor),
      self.imageView.heightAnchor.constraint(equalTo: self.sampleView.heightAnchor),
      self.imageView.centerYAnchor.constraint(equalTo: self.sampleView.centerYAnchor),
      self.imageView.widthAnchor.constraint(equalToConstant: 30),
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animate()
    let delay = 1.0
    DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
      Timer.scheduledTimer(withTimeInterval: self.duration + delay, repeats: true) { timer in
        self.animate()
      }
    }
//    self.sampleView.animateShimmer()
  }
  
  private func animate() {
    self.imageView.layer.removeAnimation(forKey: "myAnimation")
    let animation = CABasicAnimation(keyPath: "position.x")
    animation.fromValue = 0
    animation.toValue = self.sampleView.bounds.width
    animation.duration = self.duration
    animation.repeatCount = 1
    animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
    self.imageView.layer.add(animation, forKey: "myAnimation")
  }
}

extension UIView {
  func animateShimmer() {
    let gradientLayer = CAGradientLayer()
    let gradationColor = [UIColor.clear, .white.withAlphaComponent(0.3), .clear]
    gradientLayer.frame = self.bounds
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.colors = gradationColor.map { $0.cgColor }
    gradientLayer.locations = [0.0, 0.5, 1.0]
    self.layer.addSublayer(gradientLayer)
    
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [-0.7, -0.5, 0.0]
    animation.toValue = [1.0, 1.3, 1.7]
    animation.repeatCount = .infinity
    animation.duration = 1.5
    animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
    gradientLayer.add(animation, forKey: animation.keyPath)
  }
}
