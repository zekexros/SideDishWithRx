//
//  MainDish.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/30.
//

import Foundation

struct Dishes: Decodable {
    let statusCode: Int
    let body: [Dish]
}

struct Dish: Decodable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String?]
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image, alt
        case deliveryType = "delivery_type"
        case title, description
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}
