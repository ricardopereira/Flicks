//
//  User.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

private let secretKeyName = "SECRET"

// Testing purpose only
private typealias Keychain = UserDefaults

class User {

    var isAuthenticated: Bool {
        return Keychain.standard.object(forKey: secretKeyName) != nil
    }

    func setSecret(_ secret: String) {
        Keychain.standard.set(secret, forKey: secretKeyName)
    }

    func secret() -> String? {
        return Keychain.standard.string(forKey: secretKeyName)
    }

    func removeSecret() {
        return Keychain.standard.removeObject(forKey: secretKeyName)
    }

}
