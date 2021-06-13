//
//  PostDetailView.swift
//  Healios
//
//  Created by Rafael Afonso on 10/6/21.
//

import SwiftUI

struct PostDetailView: View {
    var user: User?
    var comments: [Comment]?
    var post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title)
                Spacer()
                Text(post.body)
                    .font(.body)
                Spacer()
                Text("User")
                    .font(.headline)
                Text(user?.name ?? "Anonymous")
                    .font(.subheadline)
                Spacer()
                Text("Comments:")
                    .font(.headline)
                ForEach(comments ?? [Comment]()) { comment in
                    Text(comment.body)
                        .font(.caption)
                }
                Spacer()
            }
            .padding()
        }
    }
}
