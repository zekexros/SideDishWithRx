//
//  SideDishAPI.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/02.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

protocol APIType {
    func fetchDish(path: EndPoint.Path) -> Observable<[Dish]>
    func fetchAllDishes() -> Observable<[[Dish]]>
}

class SideDishAPI: NSObject, APIType {
    private let mainDishList = BehaviorRelay<[Dish]>(value: [])
    private let soupList = BehaviorRelay<[Dish]>(value: [])
    private let sideDishList = BehaviorRelay<[Dish]>(value: [])
    private let urlSession = URLSession.shared
    
    func fetchDish(path: EndPoint.Path) -> Observable<[Dish]> {
        let url = EndPoint(path: path).url()
        let request = URLRequest(url: url!)
        
        return urlSession.rx.data(request: request)
            .map { data -> [Dish] in
                let decoder = JSONDecoder()
                let dishes = try decoder.decode(Dishes.self, from: data)
                return dishes.body
            }
            .catchAndReturn([])
    }
    
    func fetchAllDishes() -> Observable<[[Dish]]> {
        return Observable.combineLatest([fetchDish(path: .mainDish), fetchDish(path: .sideDish), fetchDish(path: .soup)])
    }
}
