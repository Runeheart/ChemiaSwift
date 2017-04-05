//
//  Alerts.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/4/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation
import UIKit

struct Alerts {
    
    static let fullyComplete: UIAlertController = {
        let result: UIAlertController = UIAlertController(title: "Structure complete!", message: "You've finished drawing your structure.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        result.addAction(cancel)
        return result
    }()
    
    static let ruleComplete: UIAlertController = {
        let result: UIAlertController = UIAlertController(title: "Rule complete!", message: "You've completed this rule. The next rule should now be enabled at the top of the screen.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        result.addAction(cancel)
        return result
    }()
    
    static let wrongAnswer: UIAlertController = {
        let wrongAnswer = UIAlertController(title: "Incorrect", message: "You haven't found the correct answer. Check the hint if you need to.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        wrongAnswer.addAction(cancel)
        return wrongAnswer
    }()
    
    
    
}
