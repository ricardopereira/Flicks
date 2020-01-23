//
//  FlicksTests.swift
//  FlicksTests
//
//  Created by Ricardo Pereira on 21/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import XCTest
import RxSwift
@testable import Flicks

class FlicksTests: XCTestCase {

    let disposeBag = DisposeBag()

    static let remotePhotos = [
        Photo(id: UUID().uuidString, urls: .init(regular: "https://0.0.0.0/regular.jpg", small: "https://0.0.0.0/small.jpg", thumb: "https://0.0.0.0/thumb.jpg"))
    ]

    class MockCoordinator: PhotosCatalogCoordinator {

        // TODO
        func pushPhoto(photo: Photo) {}
        func presentPhoto(photo: Photo) {}
        func presentShareActivity(for photo: Photo) {}
        func presentError(_ error: Error, retryBlock: (() -> Void)?) {}
        func logout() {}
        
    }

    class MockLocalStore: PhotoLocalStore {

        private(set) var photos = PublishSubject<[Photo]>()
        private(set) var data: [Photo] = [] {
            didSet {
                photos.on(.next(data))
            }
        }

        func save(_ photos: [Photo]) throws {
            self.data += photos
        }

        func failure(error: Error) {}

    }

    class MockRemoteStore: PhotoRemoteStore {

        func fetch(page: Int, perPage: Int, query: String) -> Observable<[Photo]> {
            return Observable.just(remotePhotos)
        }

    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPhotoCatalogDataProvider() {
        let localStore = MockLocalStore()
        let remoteStore = MockRemoteStore()
        let coordinator = MockCoordinator()
        let dataProvider = PhotosCatalogDataProvider(local: localStore, remote: remoteStore)

        let viewModel = PhotosCatalogViewModel(coordinator: coordinator, dataProvider: dataProvider)

        XCTAssertTrue(localStore.data.isEmpty)

        let expectation = XCTestExpectation()

        viewModel.photos
            .subscribe(
                onNext: { photos in
                    XCTAssertTrue(photos.count == 1)
                    expectation.fulfill()
                },
                onError: { error in
                    XCTFail("Should not fail")
                }
            )
            .disposed(by: disposeBag)

        viewModel.dataProvider.update()

        wait(for: [expectation], timeout: 10.0)

        XCTAssertFalse(localStore.data.isEmpty)
        XCTAssertEqual(localStore.data.first, FlicksTests.remotePhotos.first)
    }

}
