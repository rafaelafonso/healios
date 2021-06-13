//
//  UserService.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import Foundation

struct UserService {
    
    func fetchUsers(completionHandler: @escaping (Result<[User], Error>) -> Void) {
        print("->Fetch users")
        Network.request(Config.host + Endpoints.users, completionHandler: completionHandler)
    }
}
