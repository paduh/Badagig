//
//  RoundImage.swift
//  badagig
//
//  Created by Perfect Aduh on 16/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
