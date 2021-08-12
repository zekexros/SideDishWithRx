//
//  SideDishRepository.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/09.
//

import Foundation
import RxSwift

protocol RepositoryType {
    func fetch<T:Decodable>(path: EndPoint, id: String?, decodingType: T.Type) -> Observable<T>
    func fetch(url: URL) -> Observable<Data>
}

final class SideDishRepository: RepositoryType {
    private let apiService: APIType
    
    init(apiService: APIType) {
        self.apiService = apiService
    }
    
    func fetch<T:Decodable>(path: EndPoint, id: String? = nil, decodingType: T.Type) -> Observable<T> {
        return apiService.requestWithHashID(path: path, id: id, decodingType: decodingType)
    }
    
    func fetch(url: URL) -> Observable<Data> {
        return apiService.request(url: url)
    }
    
}
