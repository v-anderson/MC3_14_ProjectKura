//
//  Gradient.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 20/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func gradientSore(view: UILabel) {
        
        view.frame = bounds
        view.backgroundColor = .white
        
        
        let layer0 = CAGradientLayer()

        layer0.colors = [
          UIColor(red: 0.812, green: 0.376, blue: 0.489, alpha: 1).cgColor,
          UIColor(red: 0.871, green: 0.494, blue: 0.439, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.7, blue: 0.462, alpha: 1).cgColor
        ]
        layer0.locations = [0, 0.57, 1]
        
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        view.layer.opacity = 0.2
    }
    
    func gradientMalam(view: UILabel) {
        view.backgroundColor = UIColor(red: 0.262, green: 0.262, blue: 0.262, alpha: 0.3)
    }
    
}
