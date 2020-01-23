//
//  PhotosCatalogDataProvider.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation
import RxSwift

fileprivate let defaultLocalStore = PhotoRealmDB()
fileprivate let defaultRemoteStore = UnsplashAPI()

class PhotosCatalogDataProvider {

    private let disposeBag = DisposeBag()

    private let localStore: PhotoLocalStore
    private let remoteStore: PhotoRemoteStore

    var observable: Observable<[Photo]> {
        return localStore.photos
    }

    init(local: PhotoLocalStore = defaultLocalStore,
         remote: PhotoRemoteStore = defaultRemoteStore) {
        self.localStore = local
        self.remoteStore = remote
    }

    func update() {
        remoteStore.fetch(page: 1, perPage: 30, query: "office")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] photos in
                #warning("Testing purposes only")
                try! self?.localStore.save(photos)
            })
            .disposed(by: disposeBag)
    }

}
