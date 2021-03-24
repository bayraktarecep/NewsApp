//
//  FilterCategoryTableViewController.swift
//  News App
//
//  Created by Recep Bayraktar on 24.03.2021.
//

import UIKit

class FilterCategoryTableViewController: UITableViewController {
    
    var categoryFilterDelegate: CategoryFilterDelegate? = nil
    var category: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.category = "business"
            } else if indexPath.row == 1 {
                self.category = "entertainment"
            } else if indexPath.row == 2 {
                self.category = "general"
            } else if indexPath.row == 3 {
                self.category = "health"
            } else if indexPath.row == 4 {
                self.category = "science"
            }  else if indexPath.row == 5 {
                self.category = "sports"
            }  else if indexPath.row == 6 {
                self.category = "technology"
            }
        }
    }

    @IBAction func filterResults(_ sender: Any) {
        if let handledDelegate = self.categoryFilterDelegate {
            handledDelegate.filterCategoryBy(category: self.category)
        }
    }
    
    @IBAction func clearFilters(_ sender: Any) {
        if let handledDelegate = self.categoryFilterDelegate {
            handledDelegate.clearFilter()
        }
    }
}
