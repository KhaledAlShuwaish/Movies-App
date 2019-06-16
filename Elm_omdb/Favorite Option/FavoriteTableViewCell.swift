//
//  FavoriteTableViewCell.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 25/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var MovieGener: UILabel!
    @IBOutlet weak var MovieDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
