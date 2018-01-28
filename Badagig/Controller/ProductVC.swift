//
//  ProductVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/7/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
}

extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PRODUCT_CELL, for: indexPath) as? ProductCell {
            cell.configureCell()
            
            return cell
        }
        return UITableViewCell()
    }
}
