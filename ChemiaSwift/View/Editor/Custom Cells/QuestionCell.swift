//
//  QuestionCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/28/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    public static let identifier: String = "questionCell"

    @IBOutlet weak var questionLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
