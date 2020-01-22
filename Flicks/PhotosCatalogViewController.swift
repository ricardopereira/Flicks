//
//  PhotosCatalogViewController.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class PhotosCatalogViewController: UIViewController {

    let viewModel = PhotoCatalogViewModel()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)

        view.addSubview(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        photosCollectionView.refreshControl = UIRefreshControl()
        photosCollectionView.refreshControl?.addTarget(self, action: #selector(self.loadContent), for: .valueChanged)
    }

    @objc func loadContent() {
        photosCollectionView.refreshControl?.endRefreshing()
    }

    func presentPhoto(photo: Photo) {
        let activityViewController = UIActivityViewController(activityItems: [photo.url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    func menuContext(for photo: Photo) -> UIMenu {
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] action in
            self?.presentShareActivity(for: photo)
        }
        return UIMenu(title: "Options", children: [shareAction])
    }

    func presentShareActivity(for photo: Photo) {
        let activityViewController = UIActivityViewController(activityItems: [photo.url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

}

extension PhotosCatalogViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }

}

extension PhotosCatalogViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row]
        present(PhotoViewController(photo: photo), animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let photo = viewModel.photos[indexPath.row]
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return self.menuContext(for: photo)
        }
    }

}
