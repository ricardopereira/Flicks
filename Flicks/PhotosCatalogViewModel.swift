//
//  PhotosCatalogViewModel.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit
import RxSwift

final class PhotosCatalogViewModel {

    let coordinator: PhotosCatalogCoordinator
    let dataProvider: PhotosCatalogDataProvider

    var photos: Observable<[Photo]> {
        return dataProvider.observable
    }

    init(coordinator: PhotosCatalogCoordinator, dataProvider: PhotosCatalogDataProvider) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
    }

    func menuContext(for photo: Photo) -> UIMenu {
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
            self?.coordinator.presentShareActivity(for: photo)
        }
        return UIMenu(title: "Options", children: [shareAction])
    }

}
