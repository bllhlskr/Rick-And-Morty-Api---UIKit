//
//  MainTableViewCell.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 31.07.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var speciesLabel :UILabel!
    @IBOutlet var statusLabel :UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
