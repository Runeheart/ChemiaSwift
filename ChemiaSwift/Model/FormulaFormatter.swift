//
//  FormulaFormatter.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/16/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation
import UIKit

struct FormulaFormatter {
    init() {}
    
    func subscriptedFormulaFrom(inputString: String) -> NSMutableAttributedString {
        
        var subscripts: [Character] = []
        for temp in inputString.unicodeScalars {
            if temp.value > 48 && temp.value < 58 {
                subscripts.append(Character(temp))
            }
        }
        return NSMutableAttributedString().characterSubscriptAndSuperscript(string: inputString, characters: subscripts, type: .aSub, fontSize: 15, scriptFontSize: 10, offSet: 5, length: Array.init(repeating: 1, count: subscripts.count), alignment: .left)
    }
}

extension NSMutableAttributedString {
    enum scripting : Int
    {
        case aSub = -1
        case aSuper = 1
    }
    
    func characterSubscriptAndSuperscript(string:String,characters:[Character],type:scripting,fontSize:CGFloat,scriptFontSize:CGFloat,offSet:Int,length:[Int],alignment:NSTextAlignment)-> NSMutableAttributedString
    {
        let paraghraphStyle = NSMutableParagraphStyle()
        paraghraphStyle.alignment = alignment
        
        var scriptedCharaterLocation = Int()
        let stringFont = UIFont.boldSystemFont(ofSize: fontSize)
        let scriptFont = UIFont.boldSystemFont(ofSize: scriptFontSize)
        let attString = NSMutableAttributedString(string:string, attributes: [NSFontAttributeName:stringFont,NSForegroundColorAttributeName:UIColor.black,NSParagraphStyleAttributeName: paraghraphStyle])
        
        
        let baseLineOffset = offSet * type.rawValue
        for (i,c) in string.characters.enumerated()
        {
            for (theLength,aCharacter) in characters.enumerated()
            {
                if c == aCharacter
                {
                    scriptedCharaterLocation = i
                    attString.setAttributes([NSFontAttributeName:scriptFont,NSBaselineOffsetAttributeName:baseLineOffset,NSForegroundColorAttributeName:UIColor.black], range: NSRange(location:scriptedCharaterLocation,length:length[theLength]))
                    
                }
            }
        }
        return attString
    }
}
