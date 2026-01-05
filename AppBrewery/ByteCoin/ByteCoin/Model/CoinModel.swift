//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Luis Alvarez on 1/4/26.
//  Copyright © 2026 The App Brewery. All rights reserved.
//
struct CoinModel: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
