//
//  ViewModel.swift
//  BetaCalculadora
//
//  Created by paco on 22/10/24.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var textFieldValue: String = "0"
    
    var textFieldSavedValue: String = "0"
    var currentOperationToExecute: OperationType?
    var shouldRunOperation: Bool = false
    
    func logic (key :KeyBoardButton){
        switch key.type {
        case .number(let value):
            if shouldRunOperation{
                textFieldValue="0"
            }
            textFieldValue = textFieldValue == "0" ? "\(value)" : textFieldValue + "\(value)"
        case .operation(let operationType):
            textFieldSavedValue = textFieldValue
            currentOperationToExecute = operationType
            shouldRunOperation = true
        case .result:
            guard let operation = currentOperationToExecute else{
                return
            }
            
            switch operation{
            case .multiplication:
                textFieldValue="\(Int(textFieldSavedValue)! * Int(textFieldValue)!)"
            case .sum:
                textFieldValue="\(Int(textFieldSavedValue)! + Int(textFieldValue)!)"
            case .rest:
                textFieldValue="\(Int(textFieldSavedValue)! - Int(textFieldValue)!)"
            case .division:
                textFieldValue="\(Int(textFieldSavedValue)! / Int(textFieldValue)!)"
            }
            
        case .reset:
            textFieldValue = "0"
            textFieldSavedValue = "0"
            currentOperationToExecute = nil
            shouldRunOperation = false
        }
    }
}
