//
//  PhotosCatalogNavigationCoordinator.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class PhotosCatalogNavigationCoordinator: PhotosCatalogCoordinator {

    weak var navigationController: UINavigationController?

    func pushPhoto(photo: Photo) {
        let photoViewController = PhotoViewController(photo: photo)
        navigationController?.pushViewController(photoViewController, animated: true)
    }

    func presentPhoto(photo: Photo) {
        let photoViewController = PhotoViewController(photo: photo)
        navigationController?.present(photoViewController, animated: true, completion: nil)
    }

    func presentShareActivity(for photo: Photo) {
        guard let regularUrl = photo.regularUrl else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [regularUrl], applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }

    func presentError(_ error: Error, retryBlock: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error occurred", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(.init(title: "Retry", style: .default, handler: nil))
        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        navigationController?.present(alertController, animated: true, completion: nil)
    }

    func logout() {
        // TODO: Login
        navigationController?.setViewControllers([], animated: true)
    }

}
