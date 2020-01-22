//
//  PhotosCatalogViewModel.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

final class PhotosCatalogViewModel {

    #warning("Testing purposes only")
    let photos: [Photo] = [
        .init(url: URL(string: "https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1556761175-4b46a572b786?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1511649475669-e288648b2339?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1570126618953-d437176e8c79?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1528238646472-f2366160b6c1?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1531973576160-7125cd663d86?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1533090161767-e6ffed986c88?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
        .init(url: URL(string: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjExMTk5N30")!),
    ]

    let coordinator: PhotosCatalogCoordinator
    private let dataProvider: PhotosCatalogDataProvider

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
