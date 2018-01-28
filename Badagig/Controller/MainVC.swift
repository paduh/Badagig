//
//  MainVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.


import UIKit
import FacebookCore
import FBSDKLoginKit

class MainVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var customView: UIView!
    @IBOutlet weak var mainVCActivity: UIActivityIndicatorView!
    
    
    //Varibales
    var scrollingTImer = Timer()
    let refreshControl = UIRefreshControl()
    var indexRange: CountableClosedRange = 0...33
    var i = 0
    var photoUrlArray = [String]()
    var collectionViewImageUrl = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         photoUrlArray = ["https://watermarked.cutcaster.com/cutcaster-photo-801011074-IT-programmer-drawing-information-technology.jpg", "https://www.truelancer.com/blog/wp-content/uploads/2015/02/12.jpg", "https://fossbytes.com/wp-content/uploads/2016/02/learn-to-code-what-is-programming.jpg", "https://i.ytimg.com/vi/KXoprtDH2jk/maxresdefault.jpg"]
        print("arrayPhoto \(photoUrlArray[0])")
        self.automaticallyAdjustsScrollViewInsets = false
        reloadData()
        mainVCActivity.startAnimating()
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.backgroundView = customView
        
    }
  
    struct Storyboard {
        static let bannerTVCell = "bannerTVCell"
        static let topCategoriesTVCell = "topCategoriesTVCell"
        static let recommendedGigTVCell = "recommendedGigTVCell"
        static let bannerCVCell = "bannerCVCell"
        static let categoryHeaderCell = "categoryHeaderCell"
        static let recommendedBadaGigHeaderCell = "recommendedBadaGigHeaderCell"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let row = self.tableView.indexPathForSelectedRow?.row else { return }
        
        if segue.identifier == TO_SUB_CATEGORY_VC {
            let destinationVC = segue.destination as! SubCategoryVC
            
            switch row {
            case 2,3,4:
                let selectedcategory = BadaGigService.instance.categories[row]
                
                destinationVC.category = selectedcategory
            default:
                break
            }
        } else if segue.identifier == TO_BADAGIG_ORDER_VC {
            let destinationVC = segue.destination as! BadaGigOrderVC
            
            switch row {
                case 6,7,8..<BadaGigService.instance.requests.count:
                    print("Row \(row)")
                    let selectedBadaGig = BadaGigService.instance.requests[row]
                    
                    destinationVC.selectedBadaGig = selectedBadaGig
                default:
                break
            }
        }
    }
    
    func reloadData() {
        BadaGigService.instance.getAllCategories { (success) in
            if success {
                BadaGigService.instance.getAllRequest { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                            self.mainVCActivity.isHidden = true
                            self.mainVCActivity.stopAnimating()
                            self.tableView.isHidden = false
                    } else  {
                        AlertErrorHandler.instance.showAlert(title: "Error", message: "We could not access our service. Please check your internet connection and try again")
                    }
                }
            } else {
                print("Failed to load category")
                AlertErrorHandler.instance.showAlert(title: "Error", message: "We could not access our service. Please check your internet connection and try again")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(20000)) {
        }
    }
    
    @objc func reloadTableView() {
        reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(20000)) {
            self.refreshControl.endRefreshing()
        }
        
    }
    
    func setupView() {
        let searchBarTextAttributes = [
            NSAttributedStringKey.font.rawValue: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.darkGray,
            NSAttributedStringKey.backgroundColor.rawValue: UIColor(white: 0.95, alpha: 1.0)
            ] as [AnyHashable : NSObject]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes as! [String : Any]
        
        refreshControl.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        refreshControl.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        refreshControl.addTarget(self, action: #selector(MainVC.reloadTableView), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        
//        photoUrlArray = ["A_Photographer", "A_Song_of_Ice_and_Fire", "Another_Rockaway_Sunset", "Antelope_Butte"]
    }
    
    @IBAction func allCategoriesButtinPressed() {
        performSegue(withIdentifier: TO_CATEGORY_VC, sender: nil)
    }
    
    @IBAction func moreBUttonPressed() {
        performSegue(withIdentifier: TO_MORE_VC, sender: nil)
    }
    @IBAction func searchBarButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_SEARCH_RESULT_VC, sender: nil)
    }
    
}

extension MainVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: TO_SEARCH_RESULT_VC, sender: nil)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 2,3,4:
                performSegue(withIdentifier: TO_SUB_CATEGORY_VC, sender: indexPath)
            case 6,7,8..<BadaGigService.instance.requests.count:
                performSegue(withIdentifier: TO_BADAGIG_ORDER_VC, sender: indexPath)
            default:
                break
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - Top Banner Collection view cell
        // 1 - Top Categories cell
        // 2 - Recommeded Gig Cell
        
    
        return 3 + BadaGigService.instance.topCategories.count + BadaGigService.instance.requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
       case 0:
           if let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.bannerTVCell, for: indexPath) as? BannerTVCell {
               return cell
           }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.categoryHeaderCell, for: indexPath) as? CategoryHeaderCell {
                return cell
            }
        case 2,3,4:
            
            if indexPath.row <= BadaGigService.instance.topCategories.count - 1 {
                //                repeat {
                let category = BadaGigService.instance.topCategories[indexPath.row]
                if let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.topCategoriesTVCell, for: indexPath) as? TopCategoriesTVCell {
                    
                    cell.configureCell(category: category)
                    return cell
                }
                //                } while indexPath.row < BadaGigService.instance.categories.count
            }
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.recommendedBadaGigHeaderCell, for: indexPath) as? RecommendedBadaGigHeaderCell {
                
                return cell
            }
        case 6...8:
            
            if indexPath.row <= BadaGigService.instance.requests.count - 1 {
                let request = BadaGigService.instance.requests[indexPath.row]
                if let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.recommendedGigTVCell, for: indexPath) as? RecommendedGigTVCell {
                    cell.configureCell(gigRequest: request)
                    return cell
                }
            }
           
        default:
              return UITableViewCell()
        }
         return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let cell = cell as? BannerTVCell {
                cell.bannerCollectionView.delegate = self
                cell.bannerCollectionView.dataSource = self
                cell.bannerCollectionView.reloadData()
                
//                scrollingTImer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(cell.setupScrolling(theTime:)), userInfo: indexPath.row, repeats: true)
//                
//                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
//                    cell.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//                }, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let collectionVieCellwHeight: CGFloat = 150.0
            return collectionVieCellwHeight
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrlArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let titleToShow = BadaGigService.instance.categories[indexPath.row % BadaGigService.instance.categories.count]
        //let itemToShow = photoUrlArray[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.bannerCVCell, for: indexPath) as? BannerCVCell {
            
            cell.configureCell(collectionViewImageUrl: photoUrlArray, indexPath: indexPath)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}


