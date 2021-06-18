//
//  HealiosApp.swift
//  Healios
//
//  Created by Rafael Afonso on 14/6/21.
//

import SwiftUI
import CoreData

@main
struct HealiosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PostsListView(
                postViewModel: PostViewModel(viewContext: persistenceController.container.viewContext),
                userViewModel: UserViewModel(viewContext: persistenceController.container.viewContext),
                commentsViewModel: CommentViewModel(viewContext: persistenceController.container.viewContext))
        }
    }
}
