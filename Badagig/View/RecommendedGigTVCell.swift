//
//  RecommendedGigTVCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class RecommendedGigTVCell: UITableViewCell {
    
    //Outlests
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var startngPriceLbl: UILabel!
    @IBOutlet weak var gigTitle: UILabel!
    @IBOutlet weak var gigImage: RoundImage!
    @IBOutlet weak var userRating: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(gigRequest: Request) {
        startngPriceLbl.text = String(gigRequest.budget)
        gigTitle.text = gigRequest.description
        userNameLbl.text = UserDataService.instance.getUerName(userId: gigRequest.badaGigerId) { (success) in
            if success {
                print("username\(UserDataService.instance.userName)")
            } else {
                print("Failed to download user's names")
            }
        }
    }

}
