//
//  Item.swift
//  PopUpMenu
//
//  Created by Marto Kenarov on 17.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import Foundation
import UIKit

struct Item {
    var name: String
    var image: UIImage?
    var subItems: Array<Item>
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.subItems == rhs.subItems
    }
    
    
}
