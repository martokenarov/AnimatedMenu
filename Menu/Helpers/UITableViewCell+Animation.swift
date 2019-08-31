//
//  UITableViewCell+Animation.swift
//  Menu
//
//  Created by Marto Kenarov on 23.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func move(with positionX: CGFloat?, positionY: CGFloat?, alpha: CGFloat, duration: TimeInterval) {
        
        UIView.animate(withDuration: duration, delay: 0.0,
                       usingSpringWithDamping: 2.0,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        
                        if let positionX = positionX {
                            self.frame.origin.x = positionX
                        }
                        
                        if let positionY = positionY {
                            self.frame.origin.y = positionY
                        }
                        
                        self.alpha = alpha
        }, completion: nil)
    }
}

