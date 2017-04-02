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
    
    var elementState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .H), withTarget: CenterElementState())

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
    
    @IBAction func placeAttached(_ sender: UIButton) {
        if let ruleViewModel = skeletonRule {
            if let currentTitle = sender.currentTitle {
                sender.setTitle(ruleViewModel.nextDisplayTitle(from: currentTitle, at: .attached), for: .normal)
            } else {
                sender.setTitle(ruleViewModel.nextDisplayTitle(from: "", at: .attached), for: .normal)
            }
        }
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
