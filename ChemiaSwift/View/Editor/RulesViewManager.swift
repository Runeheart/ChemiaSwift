//
//  RulesViewManager.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation
import UIKit

final class RulesViewManager {
    
    var enteredFormula: Formula = Formula()
    var studentStruct: LewisStructure = LewisStructure()
    
    private lazy var valenceViewController: ValenceTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "ValenceTableViewController") as! ValenceTableViewController
        
        viewController.ruleViewModel = ValenceRule(withFormula: self.enteredFormula)
        
        return viewController
    }()
    
    private lazy var skeletonViewController: SkeletonTableViewController = {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "SkeletonTableViewController") as! SkeletonTableViewController
        
        viewController.ruleViewModel = SkeletonRule(withStructure: self.studentStruct)
        
        return viewController
    }()
    
    private lazy var octetsViewController: OctetsTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "OctetsTableViewController") as! OctetsTableViewController
        
        viewController.ruleViewModel = OctetsRule(withStructure: self.studentStruct)
        
        return viewController
    }()
    
    private lazy var bondsViewController: BondsTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "BondsTableViewController") as! BondsTableViewController
        
        viewController.ruleViewModel = BondsRule(withStructure: self.studentStruct)
        
        return viewController
    }()
    
    init() {}
    
    init(withFormula form: Formula) {
        self.enteredFormula = form
    }
    
    func makeViewForRule(rule: RuleName) -> UITableViewController {
        switch rule {
        case .valence:
            return valenceViewController
        case .skeleton:
            return skeletonViewController
        case .octets:
            return octetsViewController
        case .bonds:
            return bondsViewController
        }
    }
    
    func setStructure(_ struc: LewisStructure) {
        self.studentStruct = struc
    }
    
}

enum RuleName {
    case valence, skeleton, octets, bonds
}
