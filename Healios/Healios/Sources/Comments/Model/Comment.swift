//
//  Comment.swift
//  Healios
//
//  Created by Rafael Afonso on 10/6/21.
//

import Foundation

struct Comment: Identifiable, Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
