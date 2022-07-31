//
//  Model.swift
//  TestMVVMProject
//
//  Created by Шермат Эшеров on 31/7/22.
//

import Foundation

// MARK: - Currency Model

struct Currency: Codable{
    var data: [CryptoData]
    var timestamp: Int
}

struct CryptoData: Codable{
    var name: String
    var priceUsd: String
    var symbol: String
    var changePercent24Hr: String
}
