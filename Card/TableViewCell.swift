//
//  TableViewCell.swift
//  Card
//
//  Created by VERTEX24 on 2019/08/13.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personJob: UILabel!
    @IBOutlet weak var personBirth: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
