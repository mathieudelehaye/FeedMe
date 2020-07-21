//
//  EditViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 21/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class EditViewController: UITableViewController {

    lazy var backdropView: UIView = {

        let viewBounds = self.view.bounds
        
        let bdView = UIView(frame: viewBounds)
        
        return bdView
        
    }()
    
    let menuView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backdropView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.handleTap(sender:)))
        
        backdropView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
                   
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    //MARK: - TableView Data Source Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 3
    }
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditMenuCell", for: indexPath)
          
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Cell 1"
            case 1:
                cell.textLabel?.text = "Cell 2"
            case 2:
                cell.textLabel?.text = "Cell 3"
            default:
                cell.textLabel?.text = ""
        }

        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Row \(indexPath.row) selected")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
