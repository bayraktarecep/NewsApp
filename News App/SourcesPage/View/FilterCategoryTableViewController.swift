//
//  FilterCategoryTableViewController.swift
//  News App
//
//  Created by Recep Bayraktar on 24.03.2021.
//

import UIKit
import Foundation

//MARK: - UserDefaults Setting for Filters
enum SelectedFilter: Int {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    case none
}
struct UserDefaultKeys {
    static let selectedFilter = "selectedFilter"
}
//MARK: - Class
class FilterCategoryTableViewController: UITableViewController {
    
    var categoryFilterDelegate: CategoryFilterDelegate? = nil
    var category: String? = nil
    var filters = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology", "None"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Category Filters"
        self.tableView.rowHeight = 50
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = filters[indexPath.row]
        //MARK: Filter adding
        let filterNotation = UserDefaults.selectedFilter()
        
        if indexPath.row == filterNotation.rawValue {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: - Selected Filters
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
        } else if indexPath.row == 7 {
            self.category = ""
        }
        //MARK: - Filter Check
        let filterNotation = UserDefaults.selectedFilter()
        
        guard indexPath.row != filterNotation.rawValue else { return }
        
        if let newFilterNotation = SelectedFilter(rawValue: indexPath.row) {
            UserDefaults.setFilter(selectedFilter: newFilterNotation)
        }
        
        self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
    //MARK: - Remove Checkmark if another row selected
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let cell = self.tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
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
            UserDefaults.setFilter(selectedFilter: .none)
            handledDelegate.clearFilter()
        }
    }
}
//MARK: - UserDefaults extension
extension UserDefaults {
    
    static func selectedFilter() -> SelectedFilter {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaultKeys.selectedFilter)
        return SelectedFilter(rawValue: storedValue) ?? SelectedFilter.none
    }
    
    static func setFilter(selectedFilter: SelectedFilter) {
        UserDefaults.standard.set(selectedFilter.rawValue, forKey: UserDefaultKeys.selectedFilter)
    }
    
}
