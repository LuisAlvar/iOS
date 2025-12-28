//
//  Dragon.swift
//  ClassesDemo
//
//  Created by Luis Alvarez on 12/26/25.

class Dragon: Enemy {
    var wingSpan = 2
    
    func talk(speech: String){
        print("Says: \(speech)")
    }
    
    override func move() {
        print("Fly Forward!")
    }
    
    override func attack() {
        super.attack()
        print("Spits fire, does 10 damage!")
    }
}
