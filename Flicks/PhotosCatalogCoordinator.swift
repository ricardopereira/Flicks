//
//  PhotosCatalogCoordinator.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

protocol PhotosCatalogCoordinator {
    func pushPhoto(photo: Photo)
    func presentPhoto(photo: Photo)
    func presentShareActivity(for photo: Photo)
    func logout()
}
