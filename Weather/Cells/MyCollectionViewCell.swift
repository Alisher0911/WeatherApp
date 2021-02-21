//
//  MyCollectionViewCell.swift
//  Weather
//
//  Created by Alisher on 2/21/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    static let identifier = String(describing: MyCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
