//
//  BannerCVCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryDesc: UILabel!
    
    
    func configureCell(collectionViewImageUrl: [String], indexPath: IndexPath) {
//        categoryTitle.text = category.CategoryTItle
//        categoryDesc.text = category.categoryDescription
        //let url = NSURL(string: "")
        bannerImage.sd_setImage(with: URL(string: collectionViewImageUrl[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "event-managment"), options: .progressiveDownload, completed: nil)
        for url in collectionViewImageUrl {
            
        }
    }
}




