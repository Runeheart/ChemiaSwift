//
//  ElementList.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

enum ElementList {
    static let hydrogen = Element(chemSymbol: .H, group: .one, period: .first)
    static let boron = Element(chemSymbol: .B, group: .three, period: .second)
    static let carbon = Element(chemSymbol: .C, group: .four, period: .second)
    static let nitrogen = Element(chemSymbol: .N, group: .five, period: .second)
    static let oxygen = Element(chemSymbol: .O, group: .six, period: .second)
    static let fluorine = Element(chemSymbol: .F, group: .seven, period: .second)
    static let silicon = Element(chemSymbol: .Si, group: .four, period: .third)
    static let phosphorous = Element(chemSymbol: .P, group: .five, period: .third)
    static let sulfur = Element(chemSymbol: .S, group: .six, period: .third)
    static let chlorine = Element(chemSymbol: .Cl, group: .seven, period: .third)
    static let arsenic = Element(chemSymbol: .As, group: .five, period: .fourth)
    static let selenium = Element(chemSymbol: .Se, group: .six, period: .fourth)
    static let bromine = Element(chemSymbol: .Br, group: .seven, period: .fourth)
    static let krypton = Element(chemSymbol: .Kr, group: .eight, period: .fourth)
    static let tellurium = Element(chemSymbol: .Te, group: .six, period: .fifth)
    static let iodine = Element(chemSymbol: .I, group: .seven, period: .fifth)
    static let xenon = Element(chemSymbol: .Xe, group: .eight, period: .fifth)
    static let astatine = Element(chemSymbol: .At, group: .seven, period: .sixth)
    
    static let contents: [Element] = {
        return [hydrogen, boron, carbon, nitrogen, oxygen, fluorine, silicon, phosphorous, sulfur, chlorine, arsenic, selenium, bromine, krypton, tellurium, iodine, xenon, astatine]
    }()
}
