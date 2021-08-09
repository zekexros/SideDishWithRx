//
//  SideDishRepository.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/09.
//

import Foundation
import RxSwift

protocol RepositoryType {
    func fetch(path: EndPoint, id: String?) -> Observable<[Dish]>
    func fetch(url: URL) -> Observable<Data>
}

final class SideDishRepository: RepositoryType {
    private let apiService: APIType
    
    init(apiService: APIType) {
        self.apiService = apiService
    }
    
    func fetch(path: EndPoint, id: String? = nil) -> Observable<[Dish]> {
        return apiService.requestWithHashID(path: path, id: id)
    }
    
    func fetch(url: URL) -> Observable<Data> {
        return apiService.request(url: url)
    }
    
}
