//
//  HintSubmitCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/28/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class HintSubmitCell: UITableViewCell {
    
    public static let identifier: String = "hintSubmitCell"
    
    @IBOutlet weak var submitBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
