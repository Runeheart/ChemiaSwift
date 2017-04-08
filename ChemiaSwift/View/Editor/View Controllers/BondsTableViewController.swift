//
//  BondsTableViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/7/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class BondsTableViewController: UITableViewController {
    
    var ruleViewModel = BondsRule()
    var alreadyDone: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 105
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return ruleViewModel.numberOfAtoms()-1
        default: return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let result = Section(rawValue: section) else {fatalError("Unimplemented Section")}
        return result.heading
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configureCellBasedOn(path: indexPath)
        return cell
    }
    
    private func configureCellBasedOn(path: IndexPath) -> UITableViewCell {
        guard let group: Section = Section(rawValue: path.section) else {fatalError("Unimplemented Section")}
        guard let row: Row = Row(rawValue: path.row) else {fatalError("Unimplemented Row")}
        return cellForPosition((group, row), at: path)
    }
    
    private func cellForPosition(_ position: (Section, Row), at path: IndexPath) -> UITableViewCell {
        switch position {
        case (.info, .formula):
            guard let formulaCell = tableView.dequeueReusableCell(withIdentifier: FormulaCell.identifier, for: path) as? FormulaCell else {fatalError("Something very strange occurred")}
            
            formulaCell.enteredFormula = ruleViewModel.formula()
            return formulaCell
        case (.info, .submit):
            guard let submitCell = tableView.dequeueReusableCell(withIdentifier: HintSubmitCell.identifier, for: path) as? HintSubmitCell else {fatalError("Something very strange occurred")}
            
            return submitCell
        case (.center, _):
            guard let centerAtomCell = tableView.dequeueReusableCell(withIdentifier: CenterElementCell.identifier, for: path) as? CenterElementCell else {fatalError("Something very strange occurred")}
            
            centerAtomCell.bondsRule = ruleViewModel
            centerAtomCell.elementState = ruleViewModel.getCenterState()
            return centerAtomCell
        case (.attached, _):
            guard let attachedAtomCell = tableView.dequeueReusableCell(withIdentifier: AttachedElementCell.identifier, for: path) as? AttachedElementCell else {fatalError("Something very strange occurred")}
            
            attachedAtomCell.bondsRule = ruleViewModel
            attachedAtomCell.elementState = ruleViewModel.getAttachedState(atIndex: path.row)
            return attachedAtomCell
        default: break
        }
        return UITableViewCell()
    }

    
    // MARK: - Enums
    
    enum Section : Int {
        case info = 0, center, attached
        
        var heading: String {
            switch self {
            case .info: return "Information:"
            case .center: return "Center Atom"
            case .attached: return "Attached Atoms"
            }
        }
    }
    
    enum Row : Int {
        case formula = 0, submit, attached1, attached2, attached3, attached4
    }

    // MARK: - IBActions
    
    @IBAction func enableContinue(_ sender: UIButton) {
        if !alreadyDone {
            let currentState = ruleViewModel.currentState()
            setLonePairs(of: currentState)
            setBonds(of: currentState)
            checkCompletion(forState: currentState)
        }
    }
    
    private func setLonePairs(of state: FormulaState, to specific: Int? = nil) {
        if let index = specific {
            let center = state.getCenterState()
            center.setNumberOfLonePairs(to: index)
            for i in 0..<ruleViewModel.numberOfAtoms()-1 {
                let attached = state.attachedStateAt(index: i)
                attached.setNumberOfLonePairs(to: index)
            }
        } else {
            let center = state.getCenterState()
            center.setNumberOfLonePairs(to: center.lonePairNumSuggested)
            for i in 0..<ruleViewModel.numberOfAtoms()-1 {
                let attached = state.attachedStateAt(index: i)
                attached.setNumberOfLonePairs(to: attached.lonePairNumSuggested)
            }
        }
    }
    
    private func setBonds(of state: FormulaState, to specific: Int? = nil) {
        if let index = specific {
            for i in 0..<ruleViewModel.numberOfAtoms()-1 {
                let attached = state.attachedStateAt(index: i)
                attached.setNumberOfBonds(to: index, ofType: .null)
            }
        } else {
            for i in 0..<ruleViewModel.numberOfAtoms()-1 {
                let attached = state.attachedStateAt(index: i)
                attached.setNumberOfBonds(to: 1, ofType: BondType(rawValue: attached.bondNumSuggested)!)
            }
        }
    }
    
    private func checkCompletion(forState state: FormulaState) {
        state.checkCompletion(forRule: .bonds)
        if state.isCompleted() {
            alreadyDone = true
            self.present(Alerts.fullyComplete, animated: true, completion: nil)
        } else {
            setLonePairs(of: state, to: 0)
            setBonds(of: state, to: 0)
            self.present(Alerts.wrongAnswer, animated: true, completion: nil)
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bondsRule" {
            let destination = segue.destination as! RulePopupViewController
            destination.ruleToDisplay = ruleViewModel
        }
    }

}
