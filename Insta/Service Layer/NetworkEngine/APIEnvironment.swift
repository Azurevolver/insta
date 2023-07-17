//
//  APIEnvironment.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import Foundation

struct APIEnvironment {
    var baseUrl: URL
}

extension APIEnvironment {
    static let prod = APIEnvironment(baseUrl: URL(string: "https://example.com/api/v1")!)
    static let local = APIEnvironment(baseUrl: URL(string: "http://localhost:8080/api/v1")!)
}
