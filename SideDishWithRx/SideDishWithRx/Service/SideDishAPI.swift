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
    func requestWithHashID<T: Decodable>(path: EndPoint, id: String?, decodingType: T.Type) -> Observable<T>
    func request(url: URL) -> Observable<Data>
}

final class SideDishAPI: NSObject, APIType {
    private let mainDishList = BehaviorRelay<[Dish]>(value: [])
    private let soupList = BehaviorRelay<[Dish]>(value: [])
    private let sideDishList = BehaviorRelay<[Dish]>(value: [])
    private let urlSession = URLSession.shared
    
    func requestWithHashID<T: Decodable>(path: EndPoint, id: String? = nil, decodingType: T.Type) -> Observable<T> {
        let url = path.url(hashID: id)
        let request = URLRequest(url: url!)
        return urlSession.rx.data(request: request)
            .map { data -> T in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(decodingType, from: data)
                return decoded
            }
    }
    
    func request(url: URL) -> Observable<Data> {
        let urlRequest = URLRequest(url: url)
        return urlSession.rx.data(request: urlRequest)
    }
}
