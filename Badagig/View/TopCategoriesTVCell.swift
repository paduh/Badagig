//
//  TopCategoriesTVCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class TopCategoriesTVCell: UITableViewCell {
    
    //Outlets
   
    @IBOutlet weak var categoryImage: CircleImage!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var subCategoryTitle: UILabel!
    @IBOutlet weak var categoryDesc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(category: Category) {
        categoryTitle.text = category.CategoryTItle
        categoryDesc.text = category.categoryDescription
        
    }

}
