//
//  ViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 7/7/20.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift 

class DayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
}


//MARK: - TableView Data Source Methods

extension DayViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! DayCell
  
        return cell
    }
    
}

//MARK: - TableView Delegate Methods
extension DayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToDayMeals", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let destinationVC = segue.destination as! MealViewController
        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.selectedCategory = categoryArray?[indexPath.row]
//        }
    }
    
}


