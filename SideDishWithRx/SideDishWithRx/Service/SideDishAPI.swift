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

enum Errors: Error {
    case decodingError
    case networkingError
}

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
        return Observable<T>.create { [weak self] observer -> Disposable in
            let task = self?.urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                if let _ = error {
                    observer.onError(Errors.networkingError)
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let decoded = try decoder.decode(decodingType, from: data)
                        observer.onNext(decoded)
                        observer.onCompleted()
                    } catch {
                        observer.onError(Errors.decodingError)
                    }
                }
            })
            
            task?.resume()
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    func request(urlRequest: URLRequest) -> Observable<Data> {
        return Observable<Data>.create { [weak self] observer -> Disposable in
            let task = self?.urlSession.dataTask(with: urlRequest) { data, _, error in
                if let _ = error {
                    observer.onError(Errors.networkingError)
                }
                
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }
            task?.resume()
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
