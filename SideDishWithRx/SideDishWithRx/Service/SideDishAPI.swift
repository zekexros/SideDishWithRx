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
    func requestWithHashID(path: EndPoint, id: String?) -> Observable<[Dish]>
    func request(url: URL) -> Observable<Data>
}

final class SideDishAPI: NSObject, APIType {
    private let mainDishList = BehaviorRelay<[Dish]>(value: [])
    private let soupList = BehaviorRelay<[Dish]>(value: [])
    private let sideDishList = BehaviorRelay<[Dish]>(value: [])
    private let urlSession = URLSession.shared
    
    func requestWithHashID(path: EndPoint, id: String? = nil) -> Observable<[Dish]> {
        let url = path.url(hashID: id)
        let request = URLRequest(url: url!)
        return urlSession.rx.data(request: request)
            .map { data -> [Dish] in
                let decoder = JSONDecoder()
                let dishes = try decoder.decode(Dishes.self, from: data)
                return dishes.body
            }
            .catchAndReturn([])
    }
    
    func request(url: URL) -> Observable<Data> {
        let urlRequest = URLRequest(url: url)
        return urlSession.rx.data(request: urlRequest)
    }
}
