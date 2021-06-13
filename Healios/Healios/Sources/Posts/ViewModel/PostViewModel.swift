//
//  PostViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    init() {
        self.fetchPosts()
    }
    
    func fetchPosts() {
        PostService().fetchPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
