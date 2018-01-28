//
//  RoundButton.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        layer.masksToBounds = true
        layer.cornerRadius = 7
    }
}
