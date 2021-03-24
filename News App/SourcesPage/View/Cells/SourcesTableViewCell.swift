//
//  SourcesTableViewCell.swift
//  News App
//
//  Created by Recep Bayraktar on 22.03.2021.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadWith(data: Origin) {
        
        sourceName.text = data.name
        sourceDescriptionLabel.text = data.description
        
    }

}
