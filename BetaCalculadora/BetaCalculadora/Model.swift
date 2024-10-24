//
//  Model.swift
//  BetaCalculadora
//
//  Created by paco on 22/10/24.
//

import Foundation
import SwiftUI

struct KeyBoardButton : Hashable {
    let title:String
    let textColor:Color
    let backgroundColor:Color
    let isDoubleWidth:Bool
    let type:ButtonType
}

enum ButtonType : Hashable{
    case number(Int)
    case operation(OperationType)
    case result
    case reset
    case percentage
    case signChange
    case dot
}

enum OperationType: Hashable{
    case sum
    case multiplication
    case division
    case rest
    
}
