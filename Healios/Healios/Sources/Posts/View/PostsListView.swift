//
//  PostsListView.swift
//  Healios
//
//  Created by Rafael Afonso on 10/6/21.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var postViewModel: PostViewModel
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var commentsViewModel: CommentViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(postViewModel.posts) { post in
                        PostCellView(
                            post: post,
                            userViewModel: userViewModel,
                            commentsViewModel: commentsViewModel)
                    }
                }
                .background(Color.blue)
            }
        }
    }
}

struct PostCellView: View {
    var post: Post
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var commentsViewModel: CommentViewModel
    
    var body: some View {
        NavigationLink(
            destination: PostDetailView(
                user: userViewModel.user(with: post.userId),
                comments: commentsViewModel.comments(with: post.id),
                post: post))
        {
            HStack {
                VStack(alignment: .leading, spacing: nil) {
                    Text(post.title)
                        .font(.title)
                    Text(post.body)
                        .font(.body)
                }
                Spacer()
            }
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: 72.0
            )
            .background(Color.white)
            .foregroundColor(.black)
        }        
    }
}
