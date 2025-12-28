//
//  main.swift
//  OptionalsDemo
//
//  Created by Luis Alvarez on 12/27/25.
//

import Foundation

var myOptionals: String?
myOptionals = "Luis"

if myOptionals != nil {
    let safeToUse: String = myOptionals!
    print(safeToUse)
}
else {
    print("myOptional was found to be nill")
}

/*
 A shortcut for the above. is to use the following
 optional binding
 */

if let safeOptional = myOptionals {
    let safeToUse: String = safeOptional
    print(safeToUse)
}

/*
 
 What if we want to set a default value if nil
 
 */

myOptionals = nil

let text: String = myOptionals ?? "I am the default value"


print(text)


struct MyOptional {
    var property = 123
    func method() {
        print("I am the stuct's method.")
    }
}

let myOptional: MyOptional?

myOptional = nil

print(myOptional?.property)
