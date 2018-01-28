//
//  BannerTVCell.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class BannerTVCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
   
    // Variables
    
    var photoUrlArray = ["https://watermarked.cutcaster.com/cutcaster-photo-801011074-IT-programmer-drawing-information-technology.jpg", "https://www.truelancer.com/blog/wp-content/uploads/2015/02/12.jpg", "https://fossbytes.com/wp-content/uploads/2016/02/learn-to-code-what-is-programming.jpg", "https://i.ytimg.com/vi/KXoprtDH2jk/maxresdefault.jpg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell() {
    
    }
    
    @objc func setupScrolling(theTime: Timer) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
          
            self.bannerCollectionView.scrollToItem(at: theTime.userInfo as! IndexPath, at: .centeredHorizontally, animated: true)
        }, completion: nil)
    }
    
    
    func reversePhotoArray( photoArray: [String], startIndex: Int, endIndex: Int){
        var photoArray = photoArray
        if startIndex >= endIndex {
            return
        }
        
        photoArray.swapAt(startIndex, endIndex)
        
        reversePhotoArray(photoArray: photoUrlArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
    }
}


extension BannerTVCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let fullyScrolledContentOffSet: CGFloat = bannerCollectionView.frame.size.width * CGFloat(photoUrlArray.count - 1)
        if (scrollView.contentOffset.x >= fullyScrolledContentOffSet) {
            if photoUrlArray.count > 2 {
                reversePhotoArray(photoArray: photoUrlArray, startIndex: 0, endIndex: photoUrlArray.count - 1)
                reversePhotoArray(photoArray: photoUrlArray, startIndex: 0, endIndex: 1)
                reversePhotoArray(photoArray: photoUrlArray, startIndex: 2, endIndex: photoUrlArray.count - 2)
                
                let indexPath: NSIndexPath = NSIndexPath(row: 1, section: 0)
                bannerCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
                
            }
        } else if scrollView.contentOffset.x == 0 {
            if photoUrlArray.count > 2 {
                reversePhotoArray(photoArray: photoUrlArray, startIndex: 0, endIndex: photoUrlArray.count - 1)
                reversePhotoArray(photoArray: photoUrlArray, startIndex: 0, endIndex: photoUrlArray.count - 3)
                reversePhotoArray(photoArray: photoUrlArray, startIndex: photoUrlArray.count - 2, endIndex: photoUrlArray.count - 1)
                
                let indexPath: NSIndexPath = NSIndexPath(row: photoUrlArray.count - 2, section: 0)
                bannerCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            }
        }
    }
}
