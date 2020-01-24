//
//  PhotoLocalStore.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import RxSwift

protocol PhotoLocalStore {
    var photos: PublishSubject<[Photo]> { get }
    var isEmpty: Bool { get }
    func load()
    func save(_ photos: [Photo]) throws
    func failure(error: Error)
}
