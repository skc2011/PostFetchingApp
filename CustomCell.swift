//
//  CustomCell.swift
//  PostFetchingApp
//
//  Created by SKC on 9/30/19.
//  Copyright © 2019 SKC-PRO. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
 
    func setCell(hit: Hit) {
        titleLabel.text = hit.title
        createdAtLabel.text = hit.createdAt
    }
}
