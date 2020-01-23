//
//  PhotoCell.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var thumbnailTask: URLSessionTask?

    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        thumbnailTask?.cancel()
        thumbnailTask = nil
    }

    func configure(with photo: Photo) {
        DispatchQueue.main.async { [weak self] in
            self?.thumbnailTask?.cancel()
            self?.thumbnailImageView.image = UIImage() //Placeholder()

            let task = URLSession.shared.dataTask(with: photo.thumbnailUrl) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Response error: wrong request")
                    return
                }
                guard let data = data, httpResponse.statusCode == 200 else {
                    print("Response error: unexpected response status code: \(httpResponse.statusCode))")
                    return
                }
                DispatchQueue.main.async {
                    self?.thumbnailImageView.image = UIImage(data: data)
                }
            }
            task.resume()

            self?.thumbnailTask = task
        }
    }

}
