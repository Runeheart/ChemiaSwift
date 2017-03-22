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
        var dest: Element = ElementList.hydrogen
        
        init(_ source: Element) {
            self.source = source
        }
        
        func and(_ destination: Element) -> Bond {
            self.dest = destination
            return Bond(self)
        }
    }
    
    let source: Element
    let destination: Element
    
    private init(_ builder: BondBuilder) {
        source = builder.source
        destination = builder.dest
    }
    
}
