//
//  PostRequest.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import Foundation

struct PostRequest: APIRequest {
    typealias Response = [Post]
    
    var method: HTTPMethod { return .GET }
    var path: String { return "/post" }
    var body: Data? { return nil }
    
    func handle(response: Data) throws -> [Post] {
        return try JSONDecoder().decode(Response.self, from: response)
    }
}
