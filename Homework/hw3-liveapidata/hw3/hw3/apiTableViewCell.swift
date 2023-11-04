//
//  apiTableViewCell.swift
//  hw3
//
//  Created by Nathan Wangidjaja on 10/12/23.
//

import UIKit

class apiTableViewCell: UITableViewCell {
    
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateSumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
