//
//  APIRequest.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

protocol APIRequest {
    associatedtype Response
    
    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }
    
    func handle(response: Data) throws -> Response 
}
