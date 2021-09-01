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

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

protocol APIType {
    func getRequest(endPoint: EndPoint, hashID: String?, httpMethod: HTTPMethod, query: String?) -> Observable<URLRequest>
    func getRequestWithURL(url: URL) -> Observable<URLRequest>
    func request<T: Decodable>(urlRequest: URLRequest, decodingType: T.Type) -> Observable<T>
    func request(urlRequest: URLRequest) -> Observable<Data>
}

final class SideDishAPI: NSObject, APIType {
    private let urlSession = URLSession.shared
    
    func getRequest(endPoint: EndPoint, hashID: String? = nil, httpMethod: HTTPMethod, query: String? = nil) -> Observable<URLRequest> {
        let url = hashID == nil ? endPoint.url() : endPoint.url(hashID: hashID)
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return Observable<URLRequest>.just(request)
    }

    func getRequestWithURL(url: URL) -> Observable<URLRequest> {
        let request = URLRequest(url: url)
        return Observable<URLRequest>.just(request)
    }
    
    func request<T: Decodable>(urlRequest: URLRequest, decodingType: T.Type) -> Observable<T> {
        return urlSession.rx.data(request: urlRequest)
            .map { data -> T in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(decodingType, from: data)
                return decoded
            }
    }
    
    func request(urlRequest: URLRequest) -> Observable<Data> {
        return urlSession.rx.data(request: urlRequest)
    }
}
