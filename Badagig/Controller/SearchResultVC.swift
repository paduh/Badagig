//
//  SearchResultVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/13/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class SearchResultVC: UITableViewController {
    
    @IBOutlet var button: UIButton!
    
    //Variables
    var categories = [Category]()
    var filteredCategories = [Category]()
    var searchConrtoller = UISearchController()
    var resultContoller = UITableViewController()
    var footerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        searchConrtoller = UISearchController(searchResultsController: nil)
        searchConrtoller.searchBar.delegate = self
        searchConrtoller.searchResultsUpdater = self
        searchConrtoller.searchBar.placeholder = "What are you looking for?"
        searchConrtoller.dimsBackgroundDuringPresentation = false
        searchConrtoller.definesPresentationContext = true
        resultContoller.tableView.delegate = self
        resultContoller.tableView.dataSource = self
        tableView.tableHeaderView = searchConrtoller.searchBar
        
        BadaGigService.instance.categories.removeAll()
        
        tableView.reloadData()
        footerView = UIView()
        tableView.tableFooterView = nil
        footerView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        tableView.addSubview(footerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if BadaGigService.instance.categories.isEmpty {
            BadaGigService.instance.getAllCategories { (success) in
                if success {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func filterContectForSearch(searchText: String, scope: String = "All") {
        filteredCategories = BadaGigService.instance.categories.filter({ (category) -> Bool in
            return category.CategoryTItle.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchConrtoller.isActive && searchConrtoller.searchBar.text != "" {
            print("Filtered \(filteredCategories.count)")
            return self.filteredCategories.count
        }
            return BadaGigService.instance.categories.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_RESULT_CELL, for: indexPath) as? SearchResultCell  else {
            return UITableViewCell()
        }
        
        let category: Category
        if  searchConrtoller.isActive && searchConrtoller.searchBar.text != "" {
            category = self.filteredCategories[indexPath.row]
            
        } else {
            category = BadaGigService.instance.categories[indexPath.row]

        }
            cell.configureCell(category: category)
            return cell
    }
    
}

extension SearchResultVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       filterContectForSearch(searchText: searchController.searchBar.text!)
    }
}

extension SearchResultVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchConrtoller.searchBar.text = ""
        searchConrtoller.searchBar.endEditing(true)
        
        
        OperationQueue.main.addOperation {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyBoard.instantiateViewController(withIdentifier: MAIN_VC) as! MainVC
            self.present(mainVC, animated: true, completion: nil)
        }
    }
}
