//
//  SelectedTip.swift
//  Tipsy
//
//  Created by Luis Alvarez on 12/29/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

struct TipCalculator {
    var amount: Double = 0.0
    var tipPercentage: Double = 0.0
    var waysBillSplit: Int = 0
    
    func amountCalculatedPerPerson() -> Double {
        let additionalAmount = self.amount * self.tipPercentage
        return (self.amount + additionalAmount) / Double(self.waysBillSplit)
    }
    
    mutating func setAmount(Amount: Double){
        self.amount = Amount
    }
    
    mutating func setTipPercentage(TipPercentage: Double){
        self.tipPercentage = TipPercentage
    }
    
    mutating func setWaysBillSplit(WaysBillSplit: Int){
        self.waysBillSplit = WaysBillSplit
    }
    
}
