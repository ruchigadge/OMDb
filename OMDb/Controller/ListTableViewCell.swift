//
//  ListTableViewCell.swift
//  OMDb
//
//  Created by Ruchi Gadge on 02/07/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       contentView.backgroundColor = UIColor(red: 52/255, green: 47/255, blue: 86/255, alpha: 1)
        cardView.layer.cornerRadius = 3.0
    }

}
