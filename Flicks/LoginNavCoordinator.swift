//
//  LoginNavCoordinator.swift
//  Flicks
//
//  Created by Ricardo Pereira on 23/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class LoginNavCoordinator {

    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func presentPhotoCatalog() {
        let viewModel = PhotosCatalogViewModel(
            coordinator: PhotosCatalogNavCoordinator(navigationController: navigationController),
            dataProvider: PhotosCatalogDataProvider()
        )
        let photosCatalogViewController = PhotosCatalogViewController(viewModel: viewModel)
        navigationController?.setViewControllers([photosCatalogViewController], animated: true)
    }

}
