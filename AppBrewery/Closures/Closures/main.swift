//
//  main.swift
//  Closures
//
//  Created by Luis Alvarez on 1/1/26.
//

func calculator(a: Int, b: Int, operation: (Int, Int)-> Int) -> Int {
    return operation(a,b)
}


func add(a: Int, b: Int) -> Int {
    return a + b
}

var result = calculator(a: 2, b: 4, operation: add)


result = calculator(a: 2, b: 3, operation: {$0 * $1})

print(result)


let array = [6,2,3,9,4,1]

func addOne(n1: Int) -> Int {
    return n1 + 1
}

print(array.map({$0+1}))

let newArray = array.map{"\($0)"}
print(newArray)
