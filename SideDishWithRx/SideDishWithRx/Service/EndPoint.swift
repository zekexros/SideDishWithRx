//
//  EndPoint.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/02.
//

import Foundation

struct EndPoint {
    let scheme = "https"
    let host = "h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com"
    let path: Path
    let baseURL = "/develop/baminchan"
    
    func url(hashID: String? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.path = baseURL + "/" + path.pathString + "/" + (hashID ?? "")
        urlComponents.host = host
        
        return urlComponents.url
    }
    
    enum Path: String {
        case mainDish = "main"
        case sideDish = "soup"
        case soup = "side"
        case detail = "detail"
        
        var pathString: String {
            return self.rawValue
        }
    }
}
