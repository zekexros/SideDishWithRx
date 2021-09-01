//
//  SideDishRepository.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/09.
//

import Foundation
import RxSwift
import UIKit.UIImage

protocol RepositoryType {
    func fetchDish(endPoint: EndPoint) -> Observable<[Dish]>
    func fetchDetailDish(endPoint: EndPoint, hashID: String) -> Observable<DetailDish>
    func fetchImage(url: URL) -> Observable<UIImage?>
    func fetchThumbImagesData(detailDish: DetailDish) -> Observable<Data>
    func fetchDetailSectionImagesData(detailDish: DetailDish) -> Observable<Data>
}

final class SideDishRepository: RepositoryType {
    private let apiService: APIType
    
    init(apiService: APIType) {
        self.apiService = apiService
    }
    
    func fetchDish(endPoint: EndPoint) -> Observable<[Dish]> {
        return apiService.getRequest(endPoint: endPoint, hashID: nil, httpMethod: .get, query: nil)
            .flatMap { [unowned self] urlRequest in
                apiService.request(urlRequest: urlRequest, decodingType: Dishes.self).map { $0.body }
            }
    }
    
    func fetchDetailDish(endPoint: EndPoint, hashID: String) -> Observable<DetailDish> {
        return apiService.getRequest(endPoint: endPoint, hashID: hashID, httpMethod: .get, query: nil)
            .flatMap { [unowned self] urlRequest in
                apiService.request(urlRequest: urlRequest, decodingType: DetailDish.self)
            }
    }
    
    func fetchImage(url: URL) -> Observable<UIImage?> {
        return apiService.getRequestWithURL(url: url)
            .flatMap{ [unowned self] in self.apiService.request(urlRequest: $0) }
            .map { UIImage(data: $0) }
    }
    
    func fetchThumbImagesData(detailDish: DetailDish) -> Observable<Data> {
        Observable<DetailDish>.just(detailDish)
            .flatMap { Observable<String>.from($0.data.thumbImages) }
            .compactMap{ URL(string: $0) }
            .flatMap { [unowned self] in self.apiService.getRequestWithURL(url: $0) }
            .flatMap { [unowned self] in self.apiService.request(urlRequest: $0) }
    }
    
    func fetchDetailSectionImagesData(detailDish: DetailDish) -> Observable<Data> {
        Observable<DetailDish>.just(detailDish)
            .flatMap { Observable<String>.from($0.data.detailSection) }
            .compactMap{ URL(string: $0) }
            .flatMap { [unowned self] in self.apiService.getRequestWithURL(url: $0) }
            .flatMap { [unowned self] in self.apiService.request(urlRequest: $0) }
    }
}
