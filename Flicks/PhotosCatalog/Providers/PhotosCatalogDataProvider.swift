//
//  PhotosCatalogDataProvider.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

fileprivate let defaultLocalStore = PhotoRealmDB()
fileprivate let defaultRemoteStore = UnsplashAPI()

class PhotosCatalogDataProvider {

    private let disposeBag = DisposeBag()

    private let localStore: PhotoLocalStore
    private let remoteStore: PhotoRemoteStore

    var observable: Observable<[Photo]> {
        return localStore.photos
    }

    let isIndicatingActivity = BehaviorRelay(value: false)
    let isRefreshing = BehaviorRelay(value: false)

    init(local: PhotoLocalStore = defaultLocalStore,
         remote: PhotoRemoteStore = defaultRemoteStore) {
        self.localStore = local
        self.remoteStore = remote
    }

    func load() {
        localStore.load()
    }

    func update() {
        isIndicatingActivity.accept(localStore.isEmpty)
        isRefreshing.accept(true)
        remoteStore.fetch(page: 1, perPage: 30, query: "office")
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] photos in
                    self?.isIndicatingActivity.accept(false)
                    self?.isRefreshing.accept(false)
                    do {
                        try self?.localStore.save(photos)
                    }
                    catch {
                        self?.localStore.failure(error: error)
                    }
                },
                onError: { [weak self] error in
                    self?.isIndicatingActivity.accept(false)
                    self?.isRefreshing.accept(false)
                    self?.localStore.failure(error: error)
                }
            )
            .disposed(by: disposeBag)
    }

}
