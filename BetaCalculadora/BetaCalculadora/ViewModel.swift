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
                shouldRunOperation = false
            }
            textFieldValue = textFieldValue == "0" ? "\(value)" : textFieldValue + "\(value)"
        case .operation(let operationType):
            textFieldSavedValue = textFieldValue
            currentOperationToExecute = operationType
            shouldRunOperation = true
        case .result:
            guard let operation = currentOperationToExecute,
                              let savedValue = Double(textFieldSavedValue),
                              let currentValue = Double(textFieldValue) else {
                            return
                        }
            
            switch operation{
            case .multiplication:
                textFieldValue="\(savedValue * currentValue)"
            case .sum:
                textFieldValue="\(savedValue + currentValue)"
            case .rest:
                textFieldValue="\(savedValue - currentValue)"
            case .division:
                if currentValue != 0 {
                                    textFieldValue = "\(savedValue / currentValue)"
                                } else {
                                    // Manejar la división por cero
                                    textFieldValue = "Error"
                                }
                
            }
            
        case .reset:
            textFieldValue = "0"
            textFieldSavedValue = "0"
            currentOperationToExecute = nil
            shouldRunOperation = false
            
        case .percentage:
            textFieldValue = "\(Double(textFieldValue)!/100)"
        case .signChange:
            textFieldValue = "\(-Double(textFieldValue)!)"
        case .dot:
            if !textFieldValue.contains(".") {
                            textFieldValue += "."
                        }
            
        }
    }
}
