//
//  File.swift
//  SideDishWithRxTests
//
//  Created by 양준혁 on 2021/08/30.
//

import Foundation
import RxSwift

@testable import SideDishWithRx

class SideDishAPIStub: APIType {
    var requestParam = ReplaySubject<(url: URL, method: String, query: String?)>.create(bufferSize: 3)
    var requestParamForDetailDish = PublishSubject<(url: URL, method: String, query: String?)>()
    
    func getRequest(endPoint: EndPoint, httpMethod: HTTPMethod, query: String?) -> Observable<URLRequest> {
        requestParam.onNext((endPoint.url(), httpMethod.rawValue, query))
        return Observable<URLRequest>.just(URLRequest(url: endPoint.url()))
    }
    
    func getRequestWithURL(url: URL) -> Observable<URLRequest> {
        let urlRequest = URLRequest(url: url)
        return Observable<URLRequest>.just(urlRequest)
    }
    
    func getRequestWithHashID(endPoint: EndPoint, hashID: String, httpMethod: HTTPMethod, query: String?) -> Observable<URLRequest> {
        let urlRequest = URLRequest(url: endPoint.url(hashID: hashID))
        requestParam.onNext((endPoint.url(hashID: hashID), httpMethod.rawValue, query))
        return Observable<URLRequest>.just(urlRequest)
    }
    
    func request<T>(urlRequest: URLRequest, decodingType: T.Type) -> Observable<T> where T : Decodable {
        let data = NSDataAsset(name: "DetailDish")
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try! jsonDecoder.decode(decodingType, from: data!.data)
        return Observable<T>.just(decoded)
    }
    
    func request(urlRequest: URLRequest) -> Observable<Data> {
        requestParamForDetailDish.onNext((urlRequest.url!, urlRequest.httpMethod!, nil))
        return Observable<Data>.just(Data(base64Encoded: "")!)
    }
}
