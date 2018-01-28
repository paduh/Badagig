//
//  SubCategoryCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/6/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class SubCategoryCell: UITableViewCell {
    
    //  Outlets
    @IBOutlet weak var subCategoryTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(subCategory: SubCategory) {
        subCategoryTitle.text = subCategory.subCategoryTItle
    }

}
