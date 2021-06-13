//
//  PostService.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import Foundation

struct PostService {

    func fetchPosts(completionHandler: @escaping (Result<[Post], Error>) -> Void) {
        print("->Fetch posts")
        Network.request(Config.host + Endpoints.posts, completionHandler: completionHandler)
    }
}
