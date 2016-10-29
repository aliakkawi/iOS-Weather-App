//
//  CustomTableViewCell.swift
//  Weather Animation App
//
//  Created by Ali Akkawi on 28/10/2016.
//  Copyright © 2016 Ali Akkawi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var eatherImageView: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!

    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
