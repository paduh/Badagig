//
//  MaterialImageVIew.swift
//  badagig
//
//  Created by Perfect Aduh on 09/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
