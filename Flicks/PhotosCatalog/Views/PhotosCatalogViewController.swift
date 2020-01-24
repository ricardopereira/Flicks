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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = UIRefreshControl()
        return collectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .systemGray
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
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
        title = "Photos Catalog"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logoutButtonTapped))

        photosCollectionView.delegate = self
        photosCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        photosCollectionView.refreshControl?.addTarget(self, action: #selector(self.loadContent), for: .valueChanged)

        setupLayout()
        setupBindings()

        viewModel.dataProvider.load()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.dataProvider.update()
    }

    private func setupLayout() {
        view.addSubview(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        view.insertSubview(activityIndicatorView, aboveSubview: photosCollectionView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func setupBindings() {
        viewModel.photos
            .observeOn(MainScheduler.instance)
            .subscribe(
                onError: { [weak self] error in
                    self?.loadContentFailed(with: error)
                }
            )
            .disposed(by: disposeBag)

        viewModel.dataProvider.isIndicatingActivity
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        if let refreshControl = photosCollectionView.refreshControl {
            viewModel.dataProvider.isRefreshing
                .bind(to: refreshControl.rx.isRefreshing)
                .disposed(by: disposeBag)
        }

        viewModel.photos
            .bind(to: photosCollectionView.rx.items(cellIdentifier: PhotoCell.reuseIdentifier, cellType: PhotoCell.self)) { row, photo, cell in
                cell.configure(with: photo)
            }
            .disposed(by: disposeBag)
    }

    func loadContentFailed(with error: Error) {
        viewModel.coordinator.presentError(error, retryBlock: {
            self.loadContent()
        })
    }

    @objc func loadContent() {
        viewModel.dataProvider.update()
    }

    @objc func logoutButtonTapped() {
        viewModel.logout()
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
