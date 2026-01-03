//
//  main.swift
//  Extensions
//
//  Created by Luis Alvarez on 1/2/26.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

extension Double {
    func round(to places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        let scaled = self * divisor
        let rounded = (scaled).rounded()
        return rounded / divisor
    }
}

var myDouble = 3.14159
print(myDouble.round(to: 3))

#if canImport(UIKit)
extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red
button.makeCircular()
#endif

