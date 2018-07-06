//
//  DetailsTableViewCell.swift
//  OMDb
//
//  Created by Ruchi Gadge on 03/07/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var runtimeAndGenre: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var titleBagroundView: UIView!
    
    @IBOutlet weak var directorName: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var storyline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
