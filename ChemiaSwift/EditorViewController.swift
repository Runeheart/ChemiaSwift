//
//  EditorViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/14/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

final class EditorViewController: UIViewController {
    
    let manager = RulesViewManager()

    @IBOutlet weak var ruleSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        setupSegmentedControl()
        
        updateView()
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
        if ruleSC.selectedSegmentIndex == 0 {
            remove(asChildViewController: manager.makeViewForRule(rule: .skeleton))
            add(asChildViewController: manager.makeViewForRule(rule: .valence))
        } else {
            remove(asChildViewController: manager.makeViewForRule(rule: .valence))
            add(asChildViewController: manager.makeViewForRule(rule: .skeleton))
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
    
    func valenceComplete() {
        ruleSC.setEnabled(true, forSegmentAt: 1)
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
