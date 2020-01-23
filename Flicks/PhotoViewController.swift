//
//  PhotoViewController.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let photo: Photo

    private lazy var photoImageView: URLImageView = {
        let imageView = URLImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        photoImageView.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        if let thumbnailUrl = photo.thumbnailUrl {
            photoImageView.loadImage(from: thumbnailUrl, placeholder: UIImage(/*Loading Placeholder*/))
        }
    }

}
