//
//  ExampleSelectionTableViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/8/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class ExampleSelectionTableViewController: UITableViewController {
    
    private let formatter: FormulaFormatter = FormulaFormatter()
    private var formulae: [Formula] = []
    private var selectedFormula: Formula = Formula()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setExamples()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 72.0
        tableView.rowHeight = UITableViewAutomaticDimension
        title = "Choose an Example"
    }
    
    private func setExamples() {
        addMethane()
        addCCl4()
        addCO2()
    }
    
    private func addMethane() {
        let formula: Formula = Formula()
        formula.setCenter(element: ElementFactory.create(withSymbol: .C))
        let attachedElement: Element = ElementFactory.create(withSymbol: .H)
        formula.addAttached(element: attachedElement)
        formula.updateAttached(element: attachedElement, value: 4)
        formulae.append(formula)
    }
    
    private func addCCl4() {
        let formula: Formula = Formula()
        formula.setCenter(element: ElementFactory.create(withSymbol: .C))
        let attachedElement: Element = ElementFactory.create(withSymbol: .Cl)
        formula.addAttached(element: attachedElement)
        formula.updateAttached(element: attachedElement, value: 4)
        formulae.append(formula)
    }
    
    private func addCO2() {
        let formula: Formula = Formula()
        formula.setCenter(element: ElementFactory.create(withSymbol: .C))
        let attachedElement: Element = ElementFactory.create(withSymbol: .O)
        formula.addAttached(element: attachedElement)
        formula.updateAttached(element: attachedElement, value: 2)
        formulae.append(formula)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Example Formulae"
        }
        return "Placeholder"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell", for: indexPath)
        
        cell.textLabel?.attributedText = formatter.subscriptedFormulaFrom(inputString: formulae[indexPath.row].simpleForm())

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "example-Editor", sender: indexPath)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "example-Editor" {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! EditorViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                targetController.enteredFormula = formulae[indexPath.row]
            }
        }
    }
    

}
