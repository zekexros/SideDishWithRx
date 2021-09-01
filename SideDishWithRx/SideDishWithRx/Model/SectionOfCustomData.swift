//
//  SectionOfCustomData.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/30.
//

import Foundation
import RxDataSources

enum SectionHeader {
    case mainDish
    case sideSide
    case soup
    
    var value: String {
        switch self {
        case .mainDish:
            return "모두가 좋아하는 든든한 메인요리"
        case .sideSide:
            return "정성이 담긴 뜨끈뜨끈 국물요리"
        case .soup:
            return "식탁을 풍성하게 하는 정갈한 밑반찬"
        }
    }
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = Dish
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
