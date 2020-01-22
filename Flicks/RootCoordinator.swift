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
        #warning("Testing purposes only")
        if user.isAuthenticated {
            let navigationCoordinator = PhotosCatalogNavigationCoordinator()
            let viewModel = PhotosCatalogViewModel(
                coordinator: navigationCoordinator,
                dataProvider: PhotosCatalogDataProvider()
            )
            let photosCatalogViewController = PhotosCatalogViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: photosCatalogViewController)
            navigationCoordinator.navigationController = navigationController
            return navigationController
        }
        else {
            // TODO: Login
            return UINavigationController(rootViewController: ViewController())
        }
    }

}
