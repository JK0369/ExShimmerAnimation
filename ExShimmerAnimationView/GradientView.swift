//
//  GradientView.swift
//  ExShimmerAnimationView
//
//  Created by Jake.K on 2022/04/04.
//

import UIKit

public class GradientView: UIView {
  private var gradientLayer = CAGradientLayer()
  
  public var colors: [CGColor]? {
    get { self.gradientLayer.colors as? [CGColor] }
    set {
      self.gradientLayer.colors = newValue
      self.setNeedsLayout()
    }
  }
  
  public var startPoint: CGPoint {
    get { self.gradientLayer.startPoint }
    set {
      self.gradientLayer.startPoint = newValue
      self.setNeedsLayout()
    }
  }
  
  public var endPoint: CGPoint {
    get { self.gradientLayer.endPoint }
    set {
      self.gradientLayer.endPoint = newValue
      self.setNeedsLayout()
    }
  }
  
  public var locations: [NSNumber]? {
    get { self.gradientLayer.locations }
    set {
      self.gradientLayer.locations = newValue
      self.setNeedsLayout()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.layer.addSublayer(self.gradientLayer)//insertSublayer(self.gradientLayer, at: 0)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    self.gradientLayer.frame = self.bounds
  }
}

