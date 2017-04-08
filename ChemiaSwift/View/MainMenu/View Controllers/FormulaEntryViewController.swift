//
//  FormulaEntryViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/8/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class FormulaEntryViewController: UITableViewController, UIPickerViewDelegate {

    @IBOutlet weak var formattedFormulaLBL: UILabel!
    @IBOutlet weak var submitBTN: UIButton!
    @IBOutlet weak var resetBTN: UIButton!
    
    @IBOutlet weak var attachedPicker: UIPickerView!
    @IBOutlet weak var centerPicker: UIPickerView!
    
    @IBOutlet weak var quantitySTPR: UIStepper!
    @IBOutlet weak var quantityLBL: UILabel!
    
    let scribe: FormulaFormatter = FormulaFormatter()
    let builder: FormulaBuilder = FormulaBuilder()
    let elementsList: [Element] = ElementList.contents
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 72.0
        tableView.rowHeight = UITableViewAutomaticDimension
        title = "Enter Your Formula"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent component:Int) -> Int
    {
        return elementsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return elementsList[row].getSymbol()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        submitBTN.isEnabled = true
        var currentIndex = 0
        let chosenCenterElement = elementsList[row]
        switch pickerView.restorationIdentifier! {
        case "center":
            currentIndex = builder.changeSelection(element: chosenCenterElement, from: .center)
        case "attached":
            let chosenAdditionalElement = elementsList[row]
            currentIndex = builder.changeSelection(element: chosenAdditionalElement, from: .attached)
        default:
            break
        }
        checkAttachedPicker(index: currentIndex)
        updateFormulaLabel()
    }
    
    func checkAttachedPicker(index: Int) {
        if index == builder.formulaOrder.capacity {
            attachedPicker.isUserInteractionEnabled = false
            attachedPicker.alpha = 0.2
        } else {
            attachedPicker.isUserInteractionEnabled = true
            attachedPicker.alpha = 1.0
        }
    }
    
    func updateFormulaLabel() {
        let formulaString = builder.formulaString()
        formattedFormulaLBL.attributedText = scribe.subscriptedFormulaFrom(inputString: formulaString)
    }
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        quantityLBL.text = String(Int(quantitySTPR.value))
        let currentValue = Int(quantitySTPR.value)
        builder.resolveStepperValue(val: currentValue)
        if builder.resetStepperValue {
            setQuantityTo(val: 1.0)
        }
        updateFormulaLabel()
    }
    
    func setQuantityTo(val: Double) {
        quantitySTPR.value = val
        quantityLBL.text = String(Int(val))
    }
    
    @IBAction func resetPushed(_ sender: UIButton) {
        centerPicker.selectRow(0, inComponent: 0, animated: true)
        attachedPicker.selectRow(0, inComponent: 0, animated: true)
        if !attachedPicker.isUserInteractionEnabled {
            attachedPicker.isUserInteractionEnabled = true
            attachedPicker.alpha = 1.0
        }
        setQuantityTo(val: 1.0)
        builder.resetSelection()
        submitBTN.isEnabled = false
        updateFormulaLabel()
    }
    
    
    @IBAction func submitPushed(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Table view data source
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     // Configure the cell...
     return cell
     }
     */

     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "formula-Editor" {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! EditorViewController
            targetController.enteredFormula = builder.finalFormula()
        }
        
     }
    
}
