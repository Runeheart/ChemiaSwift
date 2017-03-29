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
    private var buttonAnswers = [Answer]()
    private var correctAnswerFound: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        defineChoices()
    }
    
    private func defineChoices() {
        var choices: [Answer] = ruleViewModel.getPossibleAnswers()
        for _ in 0..<choices.count {
            let choice: Answer = chooseRandomAnswerFrom(&choices)
            buttonAnswers.append(choice)
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
        return section == 0 ? 3 : ruleViewModel.numAnswers
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
            
            formulaCell.enteredFormula = ruleViewModel.formula
            return formulaCell
        case (.info, .question):
            guard let questionCell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: path) as? QuestionCell else {fatalError("Something very strange occurred")}
            
            questionCell.questionLBL.text = "How many valence electrons are there?"
            return questionCell
        case (.info, .submit):
            guard let submitCell = tableView.dequeueReusableCell(withIdentifier: HintSubmitCell.identifier, for: path) as? HintSubmitCell else {fatalError("Something very strange occurred")}
            
            return submitCell
        case (.answer, _):
            guard let choiceCell = tableView.dequeueReusableCell(withIdentifier: ChoiceCell.identifier, for: path) as? ChoiceCell else {fatalError("Something very strange occurred")}
            
            choiceCell.choice = buttonAnswers[path.row]
            return choiceCell
        default: break
        }
        return UITableViewCell()
    }
    
    // MARK: - Enums
    enum Section : Int {
        case info = 0, answer
        
        var heading: String {
            switch self {
            case .info: return "Information:"
            case .answer: return "Choose an answer:"
            }
        }
    }
    
    enum Row : Int {
        case formula = 0, question, submit, choice, decision
    }
    
    // MARK: - IBActions
    
    @IBAction func enableContinue(_ sender: UIButton) {
        if correctAnswerFound {
            let parent = self.parent as! EditorViewController
            parent.valenceComplete(ruleViewModel.formula)
        } else {
            let wrongAnswer = UIAlertController(title: "Incorrect", message: "You haven't found the correct answer. Check the hint if you need to.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            wrongAnswer.addAction(cancel)
            self.present(wrongAnswer, animated: true, completion: nil)
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {}
    
    @IBAction func answerChosen(_ sender: UIButton) {
        
        let chosenAnswer = buttonAnswers[buttonAnswers.index(where: {$0.content == Int(sender.currentTitle!)})!]
        
        switch chosenAnswer.isCorrect {
        case true:
            sender.setTitleColor(UIColor.yellow, for: .normal)
            sender.backgroundColor = UIColor.blue
            correctAnswerFound = true
        case false:
            sender.setTitleColor(UIColor.red, for: .normal)
            sender.backgroundColor = UIColor.gray
            correctAnswerFound = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "valenceRule" {
            let destination = segue.destination as! RulePopupViewController
            destination.ruleToDisplay = ruleViewModel
            
        }
    }
}
