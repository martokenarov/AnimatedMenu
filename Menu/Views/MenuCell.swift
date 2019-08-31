//
//  MenuCell.swift
//  PopUpMenu
//
//  Created by Marto Kenarov on 17.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2
        self.imgView.clipsToBounds = true
    }
}
