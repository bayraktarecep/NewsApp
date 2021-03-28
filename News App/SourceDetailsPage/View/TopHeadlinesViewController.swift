//
//  TopHeadlinesViewController.swift
//  News App
//
//  Created by Recep Bayraktar on 23.03.2021.
//

import UIKit
import SafariServices

class TopHeadlinesViewController: UIViewController {
    
    //MARK: - Outlets
    var id: String = ""
    var name: String = ""
    
    var viewModel = TopHeadlineViewModel()
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Page Controller Settings
        //TODO: Make Carousel View Auto Slide
        self.pageController.hidesForSinglePage = true
        self.pageController.currentPage = 0
        self.pageController.numberOfPages = 3
        
        //MARK: - Auto Resizing for cells
        self.topTableView.estimatedRowHeight = 275
        self.topTableView.rowHeight = UITableView.automaticDimension
        
        //MARK: - NavigationBar Settings
        self.navigationItem.title = self.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        
        loadData()
    }
    
    //MARK: - Reload Button Function
    @objc func reloadData() {
        self.topTableView.reloadData()
    }
    
    //MARK: - Get data from Api
    func loadData() {
        viewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        viewModel.onSuccessResponse = {
            self.topTableView.reloadData()
            self.collectionView.reloadData()
        }
        viewModel.fetchData(sources: id)
    }
    
    //MARK: - Error Alert Response
    func showAlert(title: String = "Something Wrong", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

//MARK: - TableView Delegate and Data Source
extension TopHeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlinesTableViewCell
        cell.loadWith(data: viewModel.topSources[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: viewModel.topSources[indexPath.row].url ?? "")
        let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url!, configuration: config)
               present(vc, animated: true)
        
    }
}

//MARK: - CollectionView Delegate and Data Source

extension TopHeadlinesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopHeadlinesCollectionViewCell
        cell.loadData(data: viewModel.topSources[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: viewModel.topSources[indexPath.row].url ?? "")
        let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url!, configuration: config)
               present(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/collectionView.bounds.width)
        pageController.currentPage = Int(pageIndex)
    }
}

