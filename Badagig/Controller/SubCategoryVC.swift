//
//  SubCategoryVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/6/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class SubCategoryVC: UITableViewController {
    ///Outlets
    @IBOutlet weak var headerImage: UIImageView!
    
    //Variables
    var headerView: UIView!
    var category: Category?
    let categoryTableViewImageHeader: CGFloat = 200.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsetsMake(categoryTableViewImageHeader, 0, 0, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -categoryTableViewImageHeader)
        
        updateHeaderView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        BadaGigService.instance.subCategories.removeAll()
        if let category = category {
            BadaGigService.instance.getAllSubCategoryByCategory(categoryId: category.id, compeletion: { (success) in
                if success {
                    self.tableView.reloadData()
                }
            })
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return BadaGigService.instance.subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryCell", for: indexPath) as? SubCategoryCell else {
            
            return UITableViewCell()
        }
        
        let subCategory = BadaGigService.instance.subCategories[indexPath.row]
        cell.configureCell(subCategory: subCategory)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: TO_POST_REQUEST_VC, sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = self.tableView.indexPathForSelectedRow?.row else { return }
        
        if segue.identifier == TO_POST_REQUEST_VC {
            let destinationVC = segue.destination as! PostRequestVC
            let selectedSubcategory = BadaGigService.instance.subCategories[row]
            destinationVC.passedSubCategory = selectedSubcategory
            if let passedCategory = category {
                destinationVC.passedCategory = passedCategory
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -categoryTableViewImageHeader, width: tableView.bounds.width, height: categoryTableViewImageHeader)
        if tableView.contentOffset.y < -categoryTableViewImageHeader {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    

}

