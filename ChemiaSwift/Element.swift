//
//  Element.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class Element {
    
    private var chemSymbol: ChemSymbol = .H
    private var group = 0
    private var period = 0
    
    init(chemSymbol: ChemSymbol, group: PTableGroup, period: PTablePeriod) {
        self.chemSymbol = chemSymbol
        self.group = group.value
        self.period = period.rawValue
    }
    
    func getSymbol() -> String {
        return chemSymbol.rawValue
    }
    
}

enum ChemSymbol: String {
    case H,B,C,N,O,F,Si,P,S,Cl,As,Se,Br,Kr,Te,I,Xe,At
}

enum PTableGroup {
    
    case one, three, four, five, six, seven, eight
    
    var value: Int {
        switch self {
        case .one: return 1
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        }
    }
}

enum PTablePeriod: Int {
    case one = 1, two, three, four, five, six
}

