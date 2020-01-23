//
//  PhotoRemoteStore.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoRemoteStore {
    func fetch(page: Int, perPage: Int, query: String) -> Observable<[Photo]>
}
