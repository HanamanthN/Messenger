//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Hanamantraya Nagonde on 13/09/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()

    private let database = Database.database().reference()
}
/// MARK :- Account Management
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard let foundEmail = snapshot.value as? String else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    /// Insert new uer to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePicture: URL
}
