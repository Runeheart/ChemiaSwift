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
        
        viewController.ruleViewModel = SkeletonRule(withManager: self.studentStruct.getManager())
        
        return viewController
    }()
    
    private lazy var octetsViewController: OctetsTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "OctetsTableViewController") as! OctetsTableViewController
        
        viewController.ruleViewModel = OctetsRule(withStructure: self.studentStruct)
        
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
        case .bonds: break
        }
        
        return UITableViewController()
    }
    
    func setStructure(_ struc: LewisStructure) {
        struc.setBondManagerTo(BondManager(withFormula: enteredFormula))
        self.studentStruct = struc
    }
    
}

enum RuleName {
    case valence, skeleton, octets, bonds
}
