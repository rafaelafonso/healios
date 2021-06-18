//
//  PostViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine
import CoreData

class PostViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.fetchPosts()
    }
    
    func fetchPosts() {
        PostService().fetchPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                self.deletePosts()
                self.savePosts()
            case .failure(_):
                self.posts = self.readStoredPosts()
            }
        }
    }
    
    func deletePosts() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CdPost")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("> Error on posts deletion from CoreData.")
        }
    }
    
    func savePosts() {
        posts.forEach { post in
            let cdPost = CdPost(context: viewContext)
            cdPost.id = Int16(post.id)
            cdPost.userId = Int16(post.userId)
            cdPost.title = post.title
            cdPost.body = post.body
            do {
                try viewContext.save()
            } catch (let error) {
                print("> Error on viewContext saving: \(error.localizedDescription)")
            }
        }
    }
    
    func readStoredPosts() -> [Post] {
        var results: [CdPost]
        do {
            results = try viewContext.fetch(CdPost.fetchRequest())
            var posts = [Post]()
            results.forEach { cdPost in
                let post = Post(
                    userId: Int(cdPost.userId),
                    id: Int(cdPost.id),
                    title: cdPost.title ?? "",
                    body: cdPost.body ?? "")
                posts.append(post)
            }
            return posts
        } catch (let error) {
            print("> Error fetching posts from CoreData: \(error.localizedDescription)")
            return posts
        }
    }
}
