//
//  PhotoRealmDB.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class PhotoRealmDB: PhotoLocalStore {

    private let realm: Realm
    private let results: Results<PhotoRealmModel>
    private var realmObserverToken: NotificationToken?

    let photos = PublishSubject<[Photo]>()

    var isEmpty: Bool {
        return results.isEmpty
    }

    init() {
        realm = try! Realm()
        results = realm.objects(PhotoRealmModel.self)

        realmObserverToken = results.observe { [weak self] _ in
            self?.publish()
        }
    }

    deinit {
        realmObserverToken?.invalidate()
        realmObserverToken = nil
    }

    private func publish() {
        photos.onNext(results.map(Photo.init(realmObject:)))
    }

    func load() {
        publish()
    }

    func save(_ photos: [Photo]) throws {
        try realm.write {
            photos.forEach { photo in
                let rlmPhoto = PhotoRealmModel()
                rlmPhoto.id = photo.id
                rlmPhoto.urlRegular = photo.urls.regular
                rlmPhoto.urlSmall = photo.urls.small
                rlmPhoto.urlThumb = photo.urls.thumb
                realm.add(rlmPhoto, update: .all)
            }
        }
    }

    func failure(error: Error) {
        photos.onError(error)
    }

}
