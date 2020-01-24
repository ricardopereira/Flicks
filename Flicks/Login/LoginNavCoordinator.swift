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

    func presentError(_ error: Error) {
        let alertController = UIAlertController(title: "Error occurred", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        navigationController?.present(alertController, animated: true, completion: nil)
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
