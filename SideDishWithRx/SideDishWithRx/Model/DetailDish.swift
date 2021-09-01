//
//  DetailDish.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/09.
//

import Foundation

struct DetailDish: Decodable {
    let hash: String
    let data: DishInformation
}

struct DishInformation: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
}
