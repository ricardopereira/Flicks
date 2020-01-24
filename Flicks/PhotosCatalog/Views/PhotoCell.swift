//
//  PhotoCell.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    private lazy var thumbnailImageView: URLImageView = {
        let imageView = URLImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

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
        thumbnailImageView.cancel()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.cancel()
    }

    func configure(with photo: Photo) {
        guard let thumbnailUrl = photo.thumbnailUrl else {
            return
        }
        thumbnailImageView.loadImage(from: thumbnailUrl, placeholder: UIImage(/*Loading Placeholder*/))
    }

}
