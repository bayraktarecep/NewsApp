//
//  TopHeadlinesTableViewCell.swift
//  News App
//
//  Created by Recep Bayraktar on 23.03.2021.
//

import UIKit
import Kingfisher

class TopHeadlinesTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    //TODO: Make button available
    @IBOutlet weak var readingListButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadWith(data: NewsModel) {
        
        newsTitle.text = data.title
        
        let inputTime = data.publishedAt
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: inputTime!) {
            print(date)
            formatter.dateFormat = "HH:mm:ss"
            timeLabel.text = formatter.string(from: date)
        }
        
        newsImage.kf.indicatorType = .activity
        let imageUrl = URL(string: data.urlToImage ?? "")
        newsImage.kf.setImage(with: imageUrl)
    }
    

}
