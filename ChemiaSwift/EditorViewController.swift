//
//  EditorViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/14/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

final class EditorViewController: UIViewController {
    
    var enteredFormula: Formula = Formula()
    
    var manager = RulesViewManager()
    var studentStructure: LewisStructure = LewisStructure()

    @IBOutlet weak var ruleSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        setupSegmentedControl()
        setupManager()
        updateView()
    }
    
    private func setupManager() {
        let sampleFormula = Formula()
        let sampleCenter = ElementFactory.create(withSymbol: .C)
        let sampleAttached = ElementFactory.create(withSymbol: .H)
        sampleFormula.setCenter(element: sampleCenter)
        sampleFormula.addAttached(element: sampleAttached)
        sampleFormula.updateAttached(element: sampleAttached, value: 4)
        enteredFormula = sampleFormula
        manager = RulesViewManager(withFormula: enteredFormula)
    }
    
    private func setupSegmentedControl() {
        ruleSC.removeAllSegments()
        ruleSC.insertSegment(withTitle: "Valence", at: 0, animated: false)
        ruleSC.insertSegment(withTitle: "Skeleton", at: 1, animated: false)
        ruleSC.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        ruleSC.setEnabled(false, forSegmentAt: 1)
        ruleSC.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        switch ruleSC.selectedSegmentIndex {
        case 0:
            if let currentChild = self.childViewControllers.last {
                remove(asChildViewController: currentChild)
            }
            add(asChildViewController: manager.makeViewForRule(rule: .valence))
        case 1:
            remove(asChildViewController: self.childViewControllers.last!)
            add(asChildViewController: manager.makeViewForRule(rule: .skeleton))
            addSegmentForRule(.octets)
        default:
            break
        }
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParentViewController()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChildViewController(viewController)
        
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func addSegmentForRule( _ rule: RuleName) {
        switch rule {
        case .octets:
            if ruleSC.numberOfSegments == 2 {
                ruleSC.insertSegment(withTitle: "Octets", at: 2, animated: true)
                ruleSC.setEnabled(false, forSegmentAt: 2)
                // ruleSC.sizeToFit()   // might be necessary later if the segments look off
            }
        default:
            break
        }
    }
    
    func valenceComplete(_ enteredFormula: Formula) {
        ruleSC.setEnabled(true, forSegmentAt: 1)
        studentStructure = LewisStructure(withFormula: enteredFormula)
        manager.setStructure(studentStructure)
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
