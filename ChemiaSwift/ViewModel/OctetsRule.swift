//
//  OctetsRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/4/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class OctetsRule: LewisRule {
    
    var currentStructure: LewisStructure
    
    init(withStructure struc: LewisStructure) {
        currentStructure = struc
    }
    
    override func description() -> String {
        return "Now, you'll want to place any lone pairs on your atoms."
    }
    
    
}
