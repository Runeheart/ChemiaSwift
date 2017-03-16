//
//  RuleView.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation
import UIKit

protocol RulesView {
    
    var ruleViewModel: LewisRule { get }
    var answerButtons: [UIButton] {get set}
    
    
}
