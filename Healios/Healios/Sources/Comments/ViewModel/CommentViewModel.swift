//
//  CommentViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine

class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment]?
    
    init() {
        self.fetchComments()
    }
    
    private func fetchComments() {
        CommentService().fetchComments { result in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func comments(with postId: Int) -> [Comment]? {
        guard let allComments = self.comments else { return nil }
        let comments = allComments.filter { $0.postId == postId }
        return comments
    }
}
