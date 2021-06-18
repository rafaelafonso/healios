//
//  CommentViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine
import CoreData

class CommentViewModel: ObservableObject {
    
    @Published var comments = [Comment]()
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.fetchComments()
    }
    
    private func fetchComments() {
        CommentService().fetchComments { result in
            switch result {
            case .success(let comments):
                self.comments = comments
                self.deleteComments()
                self.saveComments()
            case .failure(_):
                self.comments = self.readStoredComments()
            }
        }
    }
    
    func comments(with postId: Int) -> [Comment]? {
        let comments = self.comments.filter { $0.postId == postId }
        return comments
    }
    
    func deleteComments() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CdComment")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("> Error on users deletion from CoreData.")
        }
    }
    
    func saveComments() {
        comments.forEach { comment in
            let cdComment = CdComment(context: viewContext)
            cdComment.id = Int16(comment.id)
            cdComment.postId = Int16(comment.postId)
            cdComment.body = comment.body
            do {
                try viewContext.save()
            } catch (let error) {
                print("> Error on viewContext saving: \(error.localizedDescription)")
            }
        }
    }
    
    func readStoredComments() -> [Comment] {
        var results: [CdComment]
        do {
            results = try viewContext.fetch(CdComment.fetchRequest())
            var comments = [Comment]()
            results.forEach { cdComment in
                let comment = Comment(
                    postId: Int(cdComment.postId),
                    id: Int(cdComment.id),
                    name: "",
                    email: "",
                    body: cdComment.body ?? "")
                comments.append(comment)
            }
            return comments
        } catch (let error) {
            print("> Error fetching comments from CoreData: \(error.localizedDescription)")
            return comments
        }
    }
}
