//
//  Element.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class Element : CustomStringConvertible {
    
    private var chemSymbol: ChemSymbol = .H
    private var group = 0
    private var period = 0
    
    var description: String {
        return "\(chemSymbol) ; hash \(hashValue)\n\tgroup \(PTableGroup(rawValue: group)!) \n\t \(PTablePeriod(rawValue: period)!) period"
    }
    
    fileprivate init(chemSymbol: ChemSymbol, group: PTableGroup, period: PTablePeriod) {
        self.chemSymbol = chemSymbol
        self.group = group.rawValue
        self.period = period.rawValue
    }
    
    convenience init() {
        self.init(chemSymbol: .H, group: .one, period: .first)
    }
    
    func getSymbol() -> String {
        return chemSymbol.rawValue
    }
    
    func numValElectrons() -> Int {
        return group
    }
    
    enum ChemSymbol: String {
        case H,B,C,N,O,F,Si,P,S,Cl,As,Se,Br,Kr,Te,I,Xe,At
        
    }
    
    enum PTableGroup: Int {
        case one = 1
        case three = 3, four, five, six, seven, eight
    }
    
    enum PTablePeriod: Int {
        case first = 1, second, third, fourth, fifth, sixth
    }
    
}

extension Element: Hashable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: Element, rhs: Element) -> Bool {
        return lhs.getSymbol() == rhs.getSymbol()
    }

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }

    
}

enum ElementList {
    static let hydrogen = ElementFactory.create(withSymbol: .H)
    private static let boron = ElementFactory.create(withSymbol: .B)
    private static let carbon = ElementFactory.create(withSymbol: .C)
    private static let nitrogen = ElementFactory.create(withSymbol: .N)
    private static let oxygen = ElementFactory.create(withSymbol: .O)
    private static let fluorine = ElementFactory.create(withSymbol: .F)
    private static let silicon = ElementFactory.create(withSymbol: .Si)
    private static let phosphorous = ElementFactory.create(withSymbol: .P)
    private static let sulfur = ElementFactory.create(withSymbol: .S)
    private static let chlorine = ElementFactory.create(withSymbol: .Cl)
    private static let arsenic = ElementFactory.create(withSymbol: .As)
    private static let selenium = ElementFactory.create(withSymbol: .Se)
    private static let bromine = ElementFactory.create(withSymbol: .Br)
    private static let krypton = ElementFactory.create(withSymbol: .Kr)
    private static let tellurium = ElementFactory.create(withSymbol: .Te)
    private static let iodine = ElementFactory.create(withSymbol: .I)
    private static let xenon = ElementFactory.create(withSymbol: .Xe)
    private static let astatine = ElementFactory.create(withSymbol: .At)
    
    static var contents: [Element] {
        return [hydrogen, boron, carbon, nitrogen, oxygen, fluorine, silicon, phosphorous, sulfur, chlorine, arsenic, selenium, bromine, krypton, tellurium, iodine, xenon, astatine]
    }
}

protocol ElementCreator {
    static func create(withSymbol: Element.ChemSymbol) -> Element
}

class ElementFactory : ElementCreator {
    
    internal static func create(withSymbol sym: Element.ChemSymbol) -> Element {
        switch sym {
        case .H:
            return Element(chemSymbol: .H, group: .one, period: .first)
        case .B:
            return Element(chemSymbol: .B, group: .three, period: .second)
        case .C:
            return Element(chemSymbol: .C, group: .four, period: .second)
        case .N:
            return Element(chemSymbol: .N, group: .five, period: .second)
        case .O:
            return Element(chemSymbol: .O, group: .six, period: .second)
        case .F:
            return Element(chemSymbol: .F, group: .seven, period: .second)
        case .Si:
            return Element(chemSymbol: .Si, group: .four, period: .third)
        case .P:
            return Element(chemSymbol: .P, group: .five, period: .third)
        case .S:
            return Element(chemSymbol: .S, group: .six, period: .third)
        case .Cl:
            return Element(chemSymbol: .Cl, group: .seven, period: .third)
        case .As:
            return Element(chemSymbol: .As, group: .five, period: .fourth)
        case .Se:
            return Element(chemSymbol: .Se, group: .six, period: .fourth)
        case .Br:
            return Element(chemSymbol: .Br, group: .seven, period: .fourth)
        case .Kr:
            return Element(chemSymbol: .Kr, group: .eight, period: .fourth)
        case .Te:
            return Element(chemSymbol: .Te, group: .six, period: .fifth)
        case .I:
            return Element(chemSymbol: .I, group: .seven, period: .fifth)
        case .Xe:
            return Element(chemSymbol: .Xe, group: .eight, period: .fifth)
        case .At:
            return Element(chemSymbol: .At, group: .seven, period: .sixth)
        }
    }
    
}
