//
//  HealiosApp.swift
//  Healios
//
//  Created by Rafael Afonso on 10/6/21.
//

import SwiftUI

@main
struct HealiosApp: App {
    var body: some Scene {
        WindowGroup {
            PostsListView(
                postViewModel: PostViewModel(),
                userViewModel: UserViewModel(),
                commentsViewModel: CommentViewModel())
        }
    }
}
