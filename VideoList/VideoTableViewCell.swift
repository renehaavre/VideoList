//
//  VideoTableViewCell.swift
//  VideoList
//
//  Created by Rene Haavre on 29/11/2018.
//  Copyright © 2018 Rene Haavre. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    let marginX: CGFloat = 10.0
    let marginY: CGFloat = 20.0
    
    var titleTextField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background layer
        let bgRect = self.bounds.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0))
        let bgView = UIView(frame: bgRect)
        bgView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.8)
        bgView.layer.shadowColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.8).cgColor
        bgView.layer.shadowRadius = 10.0
        bgView.layer.shadowOffset = CGSize(width: 4, height: 5)
        bgView.layer.cornerRadius = 20.0

        self.addSubview(bgView)
        titleTextField.frame = bgView.bounds.inset(by: UIEdgeInsets(top: 30, left: 80, bottom: 10, right: 0))
        titleTextField.textColor = UIColor.darkGray
        self.addSubview(titleTextField)
        bgView.sendSubviewToBack(titleTextField)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
