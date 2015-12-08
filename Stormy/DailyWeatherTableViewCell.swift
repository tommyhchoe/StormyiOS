//
//  DailyWeatherTableViewCell.swift
//  Stormy
//
//  Created by Tommy Choe on 10/28/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
