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
    let badge: [Badge?]?
}

enum Badge: String, Decodable {
    case event = "이벤트특가"
    case launch = "런칭특가"
    case main = "메인특가"
}
