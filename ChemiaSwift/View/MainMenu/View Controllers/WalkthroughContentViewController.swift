//
//  WalkthroughContentViewController.swift
//  ChemiaSwift
//
//  Created by Chase Thiebaut on 4/9/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

import UIKit

class WalkthroughContentViewController: UIViewController {
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0...4:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 5:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough2")
            dismiss(animated: true, completion: nil)
            
        default: break
        }
    }
    

    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        
        pageControl.currentPage = index
        
        switch index{
        case 0...4: forwardButton.setTitle("NEXT", for: .normal)
        case 5: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }
        
        
    }
    

    


}
