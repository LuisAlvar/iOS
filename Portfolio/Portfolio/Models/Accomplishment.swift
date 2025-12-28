//
//  Accomplishment.swift
//  Portfolio
//
//  Created by Luis Alvarez on 12/24/25.
//

import Foundation

enum AccomplishmentType: String {
    case personal = "Personal"
    case occupation = "Career"
}

struct Accomplishment {
    let id: UUID
    var type: AccomplishmentType
    var title: String
    var year: String
    var description: String
}
