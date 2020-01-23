//
//  PhotosCatalogViewController.swift
//  Flicks
//
//  Created by Ricardo Pereira on 22/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosCatalogViewController: UIViewController {

    private let viewModel: PhotosCatalogViewModel

    private let disposeBag = DisposeBag()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    init(viewModel: PhotosCatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        photosCollectionView.delegate = self
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)

        view.addSubview(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        let refreshControl = UIRefreshControl()
        photosCollectionView.refreshControl = refreshControl
        photosCollectionView.refreshControl?.addTarget(self, action: #selector(self.loadContent), for: .valueChanged)

        viewModel.photos
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        viewModel.photos
            .bind(to: photosCollectionView.rx.items(cellIdentifier: PhotoCell.reuseIdentifier, cellType: PhotoCell.self)) { row, photo, cell in
                cell.configure(with: photo)
            }
            .disposed(by: disposeBag)
    }

    @objc func loadContent() {
        viewModel.dataProvider.update()
    }

}

extension PhotosCatalogViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo: Photo = try? photosCollectionView.rx.model(at: indexPath) else {
            return
        }
        self.viewModel.coordinator.presentPhoto(photo: photo)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let photo: Photo = try? photosCollectionView.rx.model(at: indexPath) else {
            return nil
        }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return self.viewModel.menuContext(for: photo)
        }
    }

}
