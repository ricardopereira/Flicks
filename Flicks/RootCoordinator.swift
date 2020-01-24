//
//  RootCoordinator.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

final class RootCoordinator {

    static func start(with user: User) -> UINavigationController {
        let navigationController = UINavigationController()
        if user.isAuthenticated {
            let viewModel = PhotosCatalogViewModel(
                coordinator: PhotosCatalogNavCoordinator(navigationController: navigationController),
                dataProvider: PhotosCatalogDataProvider()
            )
            let photosCatalogViewController = PhotosCatalogViewController(viewModel: viewModel)
            navigationController.setViewControllers([photosCatalogViewController], animated: false)
        }
        else {
            let viewModel = LoginViewModel(
                coordinator: LoginNavCoordinator(navigationController: navigationController)
            )
            let loginViewController = LoginViewController(viewModel: viewModel)
            navigationController.setViewControllers([loginViewController], animated: false)
        }
        return navigationController
    }

}
