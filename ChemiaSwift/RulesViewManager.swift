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
    
    private lazy var valenceViewController: ValenceTableViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "ValenceTableViewController") as! ValenceTableViewController
        
        let sampleFormula = Formula()
        sampleFormula.add(element: ElementList.carbon)
        sampleFormula.add(element: ElementList.hydrogen)
        sampleFormula.updateElement(element: ElementList.hydrogen, value: 4)
        viewController.ruleViewModel = ValenceRule(withFormula: sampleFormula)
        
        return viewController
    }()
    
    private lazy var skeletonViewController: SkeletonTableViewController = {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "SkeletonTableViewController") as! SkeletonTableViewController
        
        return viewController
    }()
    
    func makeViewForRule(rule: RuleName) -> UITableViewController {
        switch rule {
        case .valence:
            return valenceViewController
        case .skeleton:
            return skeletonViewController
        case .octets: break
        case .bonds: break
        }
        
        return UITableViewController()
    }
    
}

enum RuleName {
    case valence, skeleton, octets, bonds
}
