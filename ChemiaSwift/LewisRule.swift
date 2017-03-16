//
//  LewisRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

protocol LewisRule {
    
    func getPossibleAnswers() -> [Answer]
    func description() -> String
    
}
