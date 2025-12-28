//
//  Enemy.swift
//  ClassesDemo
//
//  Created by Luis Alvarez on 12/26/25.
//
class Enemy {
    var health: Int
    var attackStrength: Int

    init(health: Int, attackStrength: Int) {
        self.health = health
        self.attackStrength = attackStrength
    }
    
    func takeDamage(amount: Int)
    {
        health = health - amount
    }
    
    func move(){
        print("Walk Forward")
    }
    
    func attack() {
        print("Land a hit, does \(attackStrength) damage")
    }
    
    
}
