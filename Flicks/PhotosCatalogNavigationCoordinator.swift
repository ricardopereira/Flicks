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
        let activityViewController = UIActivityViewController(activityItems: [photo.url], applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }

    func logout() {
        // TODO: Login
        navigationController?.setViewControllers([], animated: true)
    }

}
