//
//  PhotoRealmModel.swift
//  Flicks
//
//  Created by Ricardo Pereira on 24/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealmModel: Object {

    @objc dynamic var id = ""
    @objc dynamic var urlRegular = ""
    @objc dynamic var urlSmall = ""
    @objc dynamic var urlThumb = ""

    override class func primaryKey() -> String? {
        return "id"
    }

}

extension Photo {

    init(realmObject photo: PhotoRealmModel) {
        self.id = photo.id
        self.urls = URLOptions(
            regular: photo.urlRegular,
            small: photo.urlSmall,
            thumb: photo.urlThumb
        )
    }

}
