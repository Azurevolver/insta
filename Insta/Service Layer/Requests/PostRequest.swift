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
    var path: String { return "/posts" }
    var body: Data? { return nil }
    
    func handle(response: Data) throws -> [Post] {
        // the default for post.createdAt is Date type (double), convert it to String
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: response)
    }
}
