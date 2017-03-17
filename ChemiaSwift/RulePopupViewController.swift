//
//  RulePopupViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/16/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class RulePopupViewController: UIViewController {
    
    var ruleToDisplay = ValenceRule()

    @IBOutlet weak var descriptionTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        descriptionTV.text = ruleToDisplay.description()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
