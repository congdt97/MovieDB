//
//  CollectionViewCell.swift
//  MoviDB
//
//  Created by Apple on 7/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
        // Initialization code
    }
    
    func config() {
        containerCell.layer.cornerRadius = 5
    }

}
