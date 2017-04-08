//
//  SkeletonTableViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class SkeletonTableViewController: UITableViewController {
    
    var ruleViewModel = SkeletonRule(withManager: BondManager())
    var centerAtomState: CenterElementState? = nil
    var attachedStates: [AttachedElementState] = []
    
    var formulaState: FormulaState? = nil
    var alreadyDone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ruleViewModel.setSymbols()
        
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
        case 2: return ruleViewModel.numAtoms()-1
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
            
            formulaCell.enteredFormula = ruleViewModel.currentFormula
            return formulaCell
        case (.info, .submit):
            guard let submitCell = tableView.dequeueReusableCell(withIdentifier: HintSubmitCell.identifier, for: path) as? HintSubmitCell else {fatalError("Something very strange occurred")}
            
            return submitCell
        case (.center, _):
            guard let centerAtomCell = tableView.dequeueReusableCell(withIdentifier: CenterElementCell.identifier, for: path) as? CenterElementCell else {fatalError("Something very strange occurred")}
            
            if centerAtomState != nil {
                centerAtomCell.elementState = centerAtomState!
            } else {
                centerAtomState = CenterElementState(of: ruleViewModel.centerAtom())
                centerAtomCell.elementState = centerAtomState!
            }
            
            centerAtomCell.skeletonRule = ruleViewModel
            
            return centerAtomCell
        case (.attached, _):
            guard let attachedAtomCell = tableView.dequeueReusableCell(withIdentifier: AttachedElementCell.identifier, for: path) as? AttachedElementCell else {fatalError("Something very strange occurred")}
            
            attachedAtomCell.skeletonRule = ruleViewModel
            
            if attachedStates.count != (ruleViewModel.numAtoms() - 1) {
                let nextAttachedState = AttachedElementState(of: ruleViewModel.elementAt(index: path.row), withTarget: centerAtomState!)
                attachedAtomCell.elementState = nextAttachedState
                attachedStates.append(nextAttachedState)
            } else if attachedStates.count == (ruleViewModel.numAtoms() - 1) {
                attachedAtomCell.elementState = attachedStates[path.row]
            }
            
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
            if formulaState != nil { } else {
                centerAtomState!.clearBonds()
                for attached in attachedStates {
                    attached.setNumberOfBonds(to: attached.bondNumSuggested, ofType: .single)
                }
                formulaState = FormulaState(center: centerAtomState!, attached: attachedStates)
                checkCompletion(forState: formulaState!)
            }
        }
    }
    
    private func checkCompletion(forState state: FormulaState) {
        state.checkCompletion(forRule: .skeleton)
        if state.isCompleted() {
            alreadyDone = true
            self.present(Alerts.fullyComplete, animated: true, completion: nil)
        } else if state.ruleCompleted() {
            let parent = self.parent as! EditorViewController
            parent.skeletonComplete(state)
            self.present(Alerts.ruleComplete, animated: true, completion: nil)
        } else {
            formulaState = nil
            self.present(Alerts.wrongAnswer, animated: true, completion: nil)
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "skeletonRule" {
            let destination = segue.destination as! RulePopupViewController
            destination.ruleToDisplay = ruleViewModel
            
        }
    }
}
