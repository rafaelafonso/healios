//
//  UserViewModel.swift
//  Healios
//
//  Created by Rafael Afonso on 13/6/21.
//

import SwiftUI
import Combine
import CoreData

class UserViewModel: ObservableObject {
    
    @Published var users = [User]()
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.fetchUsers()
    }
    
    func fetchUsers() {
        UserService().fetchUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                self.deleteUsers()
                self.saveUsers()
            case .failure(_):
                self.users = self.readStoredUsers()
            }
        }
    }
    
    func user(with userId: Int) -> User? {
        let user = users.filter { $0.id == userId }.first
        return user
    }
    
    func deleteUsers() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CdUser")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("> Error on users deletion from CoreData.")
        }
    }
    
    func saveUsers() {
        users.forEach { user in
            let cdUser = CdUser(context: viewContext)
            cdUser.id = Int16(user.id)
            cdUser.name = user.name
            do {
                try viewContext.save()
            } catch (let error) {
                print("> Error on viewContext saving: \(error.localizedDescription)")
            }
        }
    }
    
    func readStoredUsers() -> [User] {
        var results: [CdUser]
        do {
            results = try viewContext.fetch(CdUser.fetchRequest())
            var users = [User]()
            results.forEach { cdUser in
                let user = User(
                    id: Int(cdUser.id),
                    name: cdUser.name ?? "",
                    username: "",
                    email: "",
                    address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geolocation(lat: "", lng: "")),
                    phone: "",
                    website: "",
                    company: Company(name: "", catchPhrase: "", bs: ""))
                users.append(user)
            }
            return users
        } catch (let error) {
            print("> Error fetching users from CoreData: \(error.localizedDescription)")
            return users
        }
    }
}

