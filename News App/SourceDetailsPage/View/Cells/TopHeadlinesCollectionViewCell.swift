//
//  TopHeadlinesCollectionViewCell.swift
//  News App
//
//  Created by Recep Bayraktar on 23.03.2021.
//

import UIKit

class TopHeadlinesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func loadData(data: NewsModel) {
        
        titleLabel.text = data.title
        
        newsImage.kf.indicatorType = .activity
        let imageUrl = URL(string: data.urlToImage)
        newsImage.kf.setImage(with: imageUrl)
        
    }
}
