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

class RLMPhoto: Object {
    @objc dynamic var id = ""
    @objc dynamic var urlRegular = ""
    @objc dynamic var urlSmall = ""
    @objc dynamic var urlThumb = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Photo {

    init(realmObject photo: RLMPhoto) {
        self.id = photo.id
        self.urls = URLOptions(
            regular: photo.urlRegular,
            small: photo.urlSmall,
            thumb: photo.urlThumb
        )
    }

}

class PhotoRealmDB: PhotoLocalStore {

    private let realm: Realm
    let photos = PublishSubject<[Photo]>()

    private var realmObserverToken: NotificationToken?

    init() {
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "Debug"))
        load()

        realmObserverToken = realm.objects(RLMPhoto.self).observe { _ in
            self.load()
        }
    }

    deinit {
        realmObserverToken?.invalidate()
        realmObserverToken = nil
    }

    func load() {
        photos.onNext(realm.objects(RLMPhoto.self).map(Photo.init(realmObject:)))
    }

    func save(_ photos: [Photo]) throws {
        try realm.write {
            photos.forEach { photo in
                let rlmPhoto = RLMPhoto()
                rlmPhoto.id = photo.id
                rlmPhoto.urlRegular = photo.urls.regular
                rlmPhoto.urlSmall = photo.urls.small
                rlmPhoto.urlThumb = photo.urls.thumb
                realm.add(rlmPhoto, update: .all)
            }
        }
        realm.refresh()
    }

}
