//
//  VideoTableViewCell.swift
//  VideoList
//
//  Created by Rene Haavre on 29/11/2018.
//  Copyright © 2018 Rene Haavre. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
