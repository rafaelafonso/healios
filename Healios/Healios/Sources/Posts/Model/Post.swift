//
//  Post.swift
//  Healios
//
//  Created by Rafael Afonso on 10/6/21.
//

import Foundation

struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
