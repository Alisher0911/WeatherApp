//
//  MyTableViewCell.swift
//  Weather
//
//  Created by Alisher on 2/21/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feels: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    static let identifier = String(describing: MyTableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
