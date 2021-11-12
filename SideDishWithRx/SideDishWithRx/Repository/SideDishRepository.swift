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
    func fetchImage(url: URL) -> Observable<Data>
    func fetchThumbImagesData(detailDish: DetailDish) -> Observable<Data>
    func fetchDetailSectionImagesData(detailDish: DetailDish) -> Observable<Data>
}

final class SideDishRepository: RepositoryType {
    private let apiService: APIType
    private let imageCache = NSCache<NSString, NSData>()
    
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
    
    func fetchImage(url: URL) -> Observable<Data> {
        let key = url.absoluteString as NSString
        
        guard let data = imageCache.object(forKey: key) else {
            return apiService.getRequestWithURL(url: url)
                .flatMap { [unowned self] in self.apiService.request(urlRequest: $0) }
                .map { [unowned self] data -> Data in
                    self.imageCache.setObject(data as NSData, forKey: key)
                    return data
                }
        }
        
        return Observable<Data>.just(data as Data)
    }
    
    func fetchThumbImagesData(detailDish: DetailDish) -> Observable<Data> {
        Observable<String>.from(detailDish.data.thumbImages)
            .compactMap{ URL(string: $0) }
            .flatMap { [unowned self] in self.fetchImage(url: $0) }
    }
    
    func fetchDetailSectionImagesData(detailDish: DetailDish) -> Observable<Data> {
        Observable<String>.from(detailDish.data.detailSection)
            .compactMap{ URL(string: $0) }
            .flatMap { [unowned self] in self.fetchImage(url: $0) }
    }
}
