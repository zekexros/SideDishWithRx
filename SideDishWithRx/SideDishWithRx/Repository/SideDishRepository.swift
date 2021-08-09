//
//  SideDishRepository.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/09.
//

import Foundation
import RxSwift

protocol RepositoryType {
    func fetch(path: EndPoint) -> Observable<[Dish]>
}

final class SideDishRepository: RepositoryType {
    private let apiService: APIType
    
    init(apiService: APIType) {
        self.apiService = apiService
    }
    
    func fetch(path: EndPoint) -> Observable<[Dish]> {
        return apiService.request(path: path)
    }
    
}
