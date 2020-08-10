//
//  AlimentTypesViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 10/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class AlimentTypesViewController: UITableViewController {

    let fullAlimentTypeList = [ "Chicken", "Oat", "Eggs", "Almond milk" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.alimentCategoryCellNibName, bundle: nil), forCellReuseIdentifier: K.alimentsCellIdentifier)    // register custom cell to table view
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fullAlimentTypeList.count
               
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.alimentsCellIdentifier, for: indexPath) as! AlimentsCell
        
        let alimentCategory = fullAlimentTypeList[indexPath.row]
        
        cell.titleLabel.text = alimentCategory
        
        return cell
        
    }
}
