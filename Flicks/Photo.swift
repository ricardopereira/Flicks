//
//  Photo.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

struct Photo: Decodable {

    struct URLOptions: Decodable {
        var regular: String
        var small: String
        var thumb: String
    }

    var id: String
    var urls: URLOptions

    #warning("Testing purposes only")
    var thumbnailUrl: URL {
        return URL(string: urls.thumb)!
    }

    var regularUrl: URL {
        return URL(string: urls.regular)!
    }

    var smallUrl: URL {
        return URL(string: urls.small)!
    }

}
