//
//  URLImageView.swift
//  Flicks
//
//  Created by Ricardo Pereira on 23/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class URLImageView: UIImageView {

    private var networkTask: URLSessionTask?

    deinit {
        cancel()
    }

    func loadImage(from url: URL, placeholder: UIImage) {
        DispatchQueue.main.async {
            self.networkTask?.cancel()
            self.image = placeholder

            let errorTitle = "Failed to load remote resource \(url.lastPathComponent):"

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(errorTitle, error.localizedDescription)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print(errorTitle, "invalid response")
                    return
                }
                guard let data = data, httpResponse.statusCode == 200 else {
                    print(errorTitle, "unexpected response with status code \(httpResponse.statusCode))")
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()

            self.networkTask = task
        }
    }

    func cancel() {
        networkTask?.cancel()
        networkTask = nil
    }

}
