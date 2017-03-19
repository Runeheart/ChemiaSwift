//
//  ValenceTableViewController.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class ValenceTableViewController: UITableViewController {
    
    var ruleViewModel = ValenceRule()
    var buttonAnswers = [UIButton : Answer]()
    
    @IBOutlet var answerButtons: [UIButton]!

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var formulaLBL: UILabel!
    @IBOutlet weak var questionLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setupTableView()
        initializeFormula()
        setQuestion()
        defineChoices()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func initializeFormula() {
        let sampleFormula = Formula()
        sampleFormula.add(element: ElementList.carbon)
        sampleFormula.add(element: ElementList.hydrogen)
        sampleFormula.updateElement(element: ElementList.hydrogen, value: 4)
        ruleViewModel = ValenceRule(withFormula: sampleFormula)
        setFormulaLabel(sampleFormula)
    }
    
    private func setFormulaLabel(_ formula: Formula) {
        let subscriptedFormula: NSAttributedString = ruleViewModel.subscriptedStringFrom(formula)
        formulaLBL.attributedText = subscriptedFormula
    }
    
    private func setQuestion() {
        questionLBL.text = "How many valence electrons are there?"
        submitButton.isEnabled = false
    }
    
    private func defineChoices() {
        var choices: [Answer] = ruleViewModel.getPossibleAnswers()
        for button in answerButtons {
            let choice: Answer = chooseRandomAnswerFrom(&choices)
            buttonAnswers[button] = choice
            button.setTitle(String(choice.content as! Int), for: .normal)
        }
    }
    
    private func chooseRandomAnswerFrom(_ answers: inout [Answer]) -> Answer {
        let randomValidIndex = Int(arc4random_uniform(UInt32(answers.count)))
        return answers.remove(at: randomValidIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        } else {
            return 5
        }
        
    }
    
    @IBAction func enableContinue(_ sender: UIButton) {
        let parent = self.parent as! EditorViewController
        
        parent.valenceComplete()
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {}
    
    @IBAction func answerChosen(_ sender: UIButton) {
        guard let chosenAnswer = buttonAnswers[sender] else { fatalError("Selected answer not wire correctly") }
        
        switch chosenAnswer.isCorrect {
        case true:
            sender.setTitleColor(UIColor.yellow, for: .normal)
            submitButton.isEnabled = true
        case false:
            sender.setTitleColor(UIColor.red, for: .normal)
            submitButton.isEnabled = false
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "valenceRule" {
            let destination = segue.destination as! RulePopupViewController
            destination.ruleToDisplay = ruleViewModel
            
        }
    }
    

}
