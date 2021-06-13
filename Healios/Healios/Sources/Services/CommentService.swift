//
//  CommentService.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import Foundation

struct CommentService {
    
    func fetchComments(completionHandler: @escaping (Result<[Comment], Error>) -> Void) {
        print("->Fetch comments")
        Network.request(Config.host + Endpoints.comments, completionHandler: completionHandler)
    }
}
