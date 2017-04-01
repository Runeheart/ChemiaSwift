//
//  CenterElementCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/29/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class CenterElementCell: UITableViewCell {
    
    static let identifier: String = "centerElementCell"
    
    var skeletonRule: SkeletonRule? = nil
    // Octets Rule
    // Bonds Rule

    @IBOutlet weak var centerBTN: UIButton!
    @IBOutlet weak var topPair: UILabel!
    @IBOutlet weak var bottomPair: UILabel!
    @IBOutlet weak var leftPair: UILabel!
    @IBOutlet weak var lonePairCount: UISegmentedControl!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        lonePairCount.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
