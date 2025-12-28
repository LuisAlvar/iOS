//
//  main.swift
//  ClassesDemo
//
//  Created by Luis Alvarez on 12/26/25.
//

import Foundation

let skleton1 = Enemy(health: 100, attackStrength: 10)
let skleton2 = skleton1

skleton1.takeDamage(amount: 10)

print(skleton2.health)
