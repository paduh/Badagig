//
//  CategoryCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/1/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func configureCell(category: Category) {
        categoryTitle.text = category.CategoryTItle
    }

}
