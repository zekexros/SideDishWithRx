//
//  SectionOfCustomData.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/30.
//

import Foundation
import RxDataSources

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
