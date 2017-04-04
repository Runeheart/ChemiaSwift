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
    
    var elementState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .H), withTarget: CenterElementState()) {
        didSet {
            configureBondLabelsFor(numberOfBonds: elementState.bondNumSuggested)
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
    
    private func configureBondLabelsFor(numberOfBonds num: Int) {
        switch num {
        case 0,1:
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
        default:
            break
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func placeAttached(_ sender: UIButton) {
        if let ruleViewModel = skeletonRule {
            if let currentTitle = sender.currentTitle {
                sender.setTitle(ruleViewModel.nextDisplayTitle(from: currentTitle, at: .attached), for: .normal)
            } else {
                sender.setTitle(ruleViewModel.nextDisplayTitle(from: "", at: .attached), for: .normal)
            }
        }
    }
    
    @IBAction func bondNumChanged(_ sender: UISegmentedControl) {
        let suggestedBondNum = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
        
        elementState.bondNumSuggested = suggestedBondNum
        configureBondLabelsFor(numberOfBonds: suggestedBondNum)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lonePairCount.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
