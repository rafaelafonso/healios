//
//  UserViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    @Published var users: [User]?
    
    init() {
        self.fetchUsers()
    }
    
    private func fetchUsers() {
        UserService().fetchUsers { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func user(with userId: Int) -> User? {
        guard let users = self.users else { return nil }
        let user = users.filter { $0.id == userId }.first
        return user
    }
}

