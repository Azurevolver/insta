//
//  Post.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import Foundation

struct Post: Codable {
    var caption: String
    var createdAt: Date
    var photoUrl: URL
}
