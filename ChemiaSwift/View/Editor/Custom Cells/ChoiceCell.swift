//
//  ChoiceCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/28/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class ChoiceCell: UITableViewCell {
    
    static let identifier: String = "choiceCell"

    @IBOutlet weak var answerButton: UIButton!
    
    var choice: Answer = Answer() {
        didSet {
            self.answerButton.setTitle(String(choice.content), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
