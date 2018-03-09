//
//  FancyCellView2.swift
//  Wirtualna Uczelnia
//
//  Created by Karol Zmyslowski on 22.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class FancyCellView2: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.borderWidth = 2
        layer.cornerRadius = 5
        layer.borderColor = UIColor(red: 0/255, green: 107/255, blue: 59/255, alpha: 1).cgColor
    }
}
