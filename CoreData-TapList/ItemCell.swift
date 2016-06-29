//
//  ItemCell.swift
//  CoreData-TapList
//
//  Created by zklgame on 6/29/16.
//  Copyright © 2016 Zhejiang University. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    var item: Item? {
        didSet {
            populateUI()
        }
    }
    
    func populateUI() {
        if let item = item {
            nameLabel.text = item.name
            scoreLabel.text = "\(item.score!)"
            photoView.image = item.image
        }
    }
}
