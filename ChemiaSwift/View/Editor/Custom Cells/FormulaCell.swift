//
//  FormulaCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/28/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class FormulaCell: UITableViewCell {
    
    public static let identifier: String = "formulaCell"
    private static var formatter: FormulaFormatter = FormulaFormatter()

    @IBOutlet weak var formulaLBL: UILabel!
    
    var enteredFormula: Formula = Formula() {
        didSet {
            self.formulaLBL.attributedText = FormulaCell.formatter.subscriptedFormulaFrom(inputString: enteredFormula.simpleForm())
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
