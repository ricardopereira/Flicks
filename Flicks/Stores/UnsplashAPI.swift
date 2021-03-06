//
//  UnsplashAPI.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UnsplashAPI: PhotoRemoteStore {

    struct SearchPhotosResponse: Decodable {
        var results: [Photo]
    }

    let domainUrl = URL(string: "https://api.unsplash.com/search/photos")!

    func fetch(page: Int, perPage: Int, query: String) -> Observable<[Photo]> {
        // Testing purpose only
        let authKey = User().secret()!

        var urlComponents = URLComponents(url: domainUrl, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage)),
            URLQueryItem(name: "query", value: query),
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("Client-ID \(authKey)", forHTTPHeaderField: "Authorization")
        let decoder = JSONDecoder()
        return URLSession.shared.rx.data(request: request)
            .flatMap { data -> Observable<[Photo]> in
                let photosResponse = try decoder.decode(SearchPhotosResponse.self, from: data)
                return Observable.just(photosResponse.results)
            }
    }

}
