//
//  Bond.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/21/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class Bond {
    
    static func between(_ source: Element) -> BondBuilder {
        return BondBuilder(source)
    }
    
    class BondBuilder {
        var source: Element
        var dest: Element = ElementFactory.create(withSymbol: .H)
        var type: BondType = .single
        
        init(_ source: Element) {
            self.source = source
        }
        
        func and(_ destination: Element, withType type: BondType = .single) -> Bond {
            self.dest = destination
            self.type = type
            return Bond(self)
        }
    }
    
    let source: Element
    let destination: Element
    var type: BondType
    
    private init(_ builder: BondBuilder) {
        source = builder.source
        destination = builder.dest
        type = builder.type
    }
    
}

enum BondType : Int {
    case null = 0, single, double, triple
}

extension Bond : Hashable, Equatable {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: Bond, rhs: Bond) -> Bool {
        return bondEqualsExact(source: lhs, destination: rhs) || bondEqualsEquivalent(source: lhs, destination: rhs)
    }
    
    static func bondEqualsExact(source lhs: Bond, destination rhs: Bond) -> Bool {
        return lhs.source === rhs.source && lhs.destination === rhs.destination
    }
    
    static func bondEqualsEquivalent(source lhs: Bond, destination rhs: Bond) -> Bool {
        return lhs.source === rhs.destination && lhs.destination === rhs.source
    }

    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
