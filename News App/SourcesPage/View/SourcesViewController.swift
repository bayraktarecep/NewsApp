//
//  ViewController.swift
//  News App
//
//  Created by Recep Bayraktar on 22.03.2021.
//

import UIKit

protocol CategoryFilterDelegate {
    func filterCategoryBy(category: String?)
    func clearFilter()
}

class SourcesViewController: UIViewController, CategoryFilterDelegate {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    var viewModel = SourcesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableView.automaticDimension
        loadData()
    }
    
    func loadData() {
        
        viewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        viewModel.onSuccessResponse = {
            self.tableView.reloadData()
        }
        
        viewModel.fetchData()
        
    }
    @IBAction func reloadData(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func filterCategories(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "filters") as? FilterCategoryTableViewController
        vc?.categoryFilterDelegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func filterCategoryBy(category: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popToRootViewController(animated: true)
            self.viewModel.onSuccessResponse = {
                self.tableView.reloadData()
            }
            self.viewModel.fetchData(categories: category)
        }
    }
    func clearFilter() {
        self.navigationController?.popToRootViewController(animated: true)
        self.tableView.reloadData()
        self.loadData()
    }
    
    
    //MARK: - Error Alert Response
    func showAlert(title: String = "Something went Wrong", message: String = "Can't access the source"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TableView Delegate and Data Source
extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.origin.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SourcesTableViewCell
        cell.loadWith(data: viewModel.origin[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topHeadlinesView = storyboard?.instantiateViewController(identifier: "TopHeadlines") as? TopHeadlinesViewController
        topHeadlinesView?.id = viewModel.origin[indexPath.row].id!
        topHeadlinesView?.name = viewModel.origin[indexPath.row].name!
        self.navigationController?.pushViewController(topHeadlinesView!, animated: true)
    }
}

