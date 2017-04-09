//
//  MainScreenViewController.swift
//  ChemiaSwift
//
//  Created by Chase Thiebaut on 4/9/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

import UIKit

class MainScreenViewController: UIViewController{
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough2"){
            return
        }
        
        if let pageViewController = storyboard!.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }
    
}
