//
//  CenterElementCell.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/29/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import UIKit

class CenterElementCell: UITableViewCell {
    
    static let identifier: String = "centerElementCell"
    
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
    // Octets Rule
    // Bonds Rule
    
    var elementState: CenterElementState = CenterElementState() {
        didSet {
            if octetsRule != nil {
                centerBTN.setTitle(elementState.suggestedElementSymbol, for: .disabled)
            }
        }
    }

    @IBOutlet weak var centerBTN: UIButton!
    @IBOutlet weak var topPair: UILabel!
    @IBOutlet weak var bottomPair: UILabel!
    @IBOutlet weak var leftPair: UILabel!
    @IBOutlet weak var lonePairCount: UISegmentedControl!
    
    private func configureForSkeleton() {
        topPair.isHidden = true
        bottomPair.isHidden = true
        leftPair.isHidden = true
        lonePairCount.isHidden = true
    }
    
    private func configureForOctets() {
        centerBTN.isEnabled = false
    }
    
    // MARK: - IBActions
    
    @IBAction func placeCenter(_ sender: UIButton) {
        if let ruleViewModel = skeletonRule {
            var nextTitle: String = ""
            if let currentTitle = sender.currentTitle {
                nextTitle = ruleViewModel.nextDisplayTitle(from: currentTitle, at: .center)
            } else {
                nextTitle = ruleViewModel.nextDisplayTitle(from: "", at: .center)
            }
            sender.setTitle(nextTitle, for: .normal)
            elementState.suggestedElementSymbol = nextTitle
        }
    }
    
    @IBAction func lonePairChanged(_ sender: UISegmentedControl) {
        
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
