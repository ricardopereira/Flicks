//
//  PhotosCatalogDataProvider.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

class PhotosCatalogDataProvider {

    static let defaultLocalStore = PhotoRealmDB()
    static let defaultRemoteStore = UnsplashAPI()

    init(local: PhotoLocalStore = PhotosCatalogDataProvider.defaultLocalStore,
         remote: PhotoRemoteStore = PhotosCatalogDataProvider.defaultRemoteStore) {

    }

}
