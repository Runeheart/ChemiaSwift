//
//  AttachedElementCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/1/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class AttachedElementCell: UITableViewCell {
    
    static let identifier: String = "attachedElementCell"
    
    var skeletonRule: SkeletonRule? = nil {
        didSet {
            self.configureForSkeleton()
        }
    }
    var octetsRule: OctetsRule? = nil {
        didSet {
            self.configureForOctets()
        }
    }
    var bondsRule: BondsRule? = nil {
        didSet {
            self.configureForBonds()
        }
    }
    
    var elementState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .H), withTarget: CenterElementState()) {
        didSet {
            configureBondLabelsFor(numberOfBonds: elementState.bondNumSuggested)
            if octetsRule != nil || bondsRule != nil {
                configureLonePairLabelsFor(numberOfPairs: elementState.lonePairNumSuggested)
                attachedBTN.setTitle(elementState.suggestedElementSymbol, for: .disabled)
                destinationLBL.text = elementState.destinationSymbol()
            }
        }
    }

    @IBOutlet weak var attachedBTN: UIButton!
    
    @IBOutlet weak var topPair: UILabel!
    @IBOutlet weak var bottomPair: UILabel!
    @IBOutlet weak var leftPair: UILabel!
    @IBOutlet weak var lonePairCount: UISegmentedControl!
    
    @IBOutlet weak var topBond: UILabel!
    @IBOutlet weak var middleBond: UILabel!
    @IBOutlet weak var bottomBond: UILabel!
    @IBOutlet weak var bondCount: UISegmentedControl!
    
    @IBOutlet weak var destinationLBL: UILabel!
    
    private func configureForSkeleton() {
        topPair.isHidden = true
        bottomPair.isHidden = true
        leftPair.isHidden = true
        lonePairCount.isHidden = true
    }
    
    private func configureForOctets() {
        attachedBTN.isEnabled = false
        bondCount.isHidden = true
    }
    
    private func configureForBonds() {
        attachedBTN.isEnabled = false
    }
    
    private func configureBondLabelsFor(numberOfBonds num: Int) {
        switch num {
        case 0:
            topBond.isEnabled = false
            middleBond.isEnabled = false
            bottomBond.isEnabled = false
        case 1:
            topBond.isEnabled = true
            middleBond.isEnabled = false
            bottomBond.isEnabled = false
        case 2:
            topBond.isEnabled = true
            middleBond.isEnabled = true
            bottomBond.isEnabled = false
        case 3:
            topBond.isEnabled = true
            middleBond.isEnabled = true
            bottomBond.isEnabled = true
        default: break
        }
    }
    
    private func configureLonePairLabelsFor(numberOfPairs num: Int) {
        switch num {
        case 0:
            topPair.isEnabled = false
            leftPair.isEnabled = false
            bottomPair.isEnabled = false
        case 1:
            topPair.isEnabled = true
            leftPair.isEnabled = false
            bottomPair.isEnabled = false
        case 2:
            topPair.isEnabled = true
            leftPair.isEnabled = true
            bottomPair.isEnabled = false
        case 3:
            topPair.isEnabled = true
            leftPair.isEnabled = true
            bottomPair.isEnabled = true
        default: break
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func placeAttached(_ sender: UIButton) {
        if let ruleViewModel = skeletonRule {
            var nextTitle: String = ""
            if let currentTitle = sender.currentTitle {
                nextTitle = ruleViewModel.nextDisplayTitle(from: currentTitle, at: .attached)
            } else {
                nextTitle = ruleViewModel.nextDisplayTitle(from: "", at: .attached)
            }
            sender.setTitle(nextTitle, for: .normal)
            elementState.suggestedElementSymbol = nextTitle
        }
    }
    
    @IBAction func bondNumChanged(_ sender: UISegmentedControl) {
        let suggestedBondNum = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
        
        elementState.bondNumSuggested = suggestedBondNum
        configureBondLabelsFor(numberOfBonds: suggestedBondNum)
    }
    
    @IBAction func lonePairNumChanged(_ sender: UISegmentedControl) {
        let suggestedLonePairNum = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
        
        elementState.lonePairNumSuggested = suggestedLonePairNum
        configureLonePairLabelsFor(numberOfPairs: suggestedLonePairNum)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
