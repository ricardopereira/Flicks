//
//  LoginViewModel.swift
//  Flicks
//
//  Created by Ricardo Pereira on 23/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

final class LoginViewModel {

    let coordinator: LoginNavCoordinator

    init(coordinator: LoginNavCoordinator) {
        self.coordinator = coordinator
    }

    func login(secret: String) {
        // Success
        User().setSecret(secret)
        coordinator.presentPhotoCatalog()
    }

}
