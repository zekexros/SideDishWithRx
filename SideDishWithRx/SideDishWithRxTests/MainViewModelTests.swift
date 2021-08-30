//
//  MainViewModelTests.swift
//  SideDishWithRxTests
//
//  Created by 양준혁 on 2021/08/18.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import SideDishWithRx

class MainViewModelTests: XCTestCase {
    private var mainViewModel: MainViewModel!
    private var sceneCoordinator: SceneCoordinator!
    private var repository: SideDishRepository!
    private var disposeBag: DisposeBag!
    private var sideDishAPIStub: SideDishAPIStub!

    override func setUp() {
        super.setUp()
        sceneCoordinator = SceneCoordinator(window: UIWindow())
        sideDishAPIStub = SideDishAPIStub()
        repository = SideDishRepository(apiService: sideDishAPIStub)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        sceneCoordinator = nil
        sideDishAPIStub = nil
        repository = nil
        disposeBag = nil
    }

    func testFetchDish() throws {
        // given
        mainViewModel = MainViewModel(sceneCoordinator: sceneCoordinator, repository: repository)

        // when
        mainViewModel.input.isViewDidLoad.accept(true)
        
        // then
        sideDishAPIStub.requestParam
            .buffer(timeSpan: .seconds(3), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { requests in
                // fetchMainDish 검증
                XCTAssertEqual(requests[0].url, EndPoint(path: .mainDish).url())
                XCTAssertEqual(requests[0].method, HTTPMethod.get.rawValue)
                XCTAssertEqual(requests[0].query, nil)
                
                // fetchSideDish 검증
                XCTAssertEqual(requests[0].url, EndPoint(path: .mainDish).url())
                XCTAssertEqual(requests[0].method, HTTPMethod.get.rawValue)
                XCTAssertEqual(requests[0].query, nil)
                
                // fetchSoup 검증
                XCTAssertEqual(requests[0].url, EndPoint(path: .mainDish).url())
                XCTAssertEqual(requests[0].method, HTTPMethod.get.rawValue)
                XCTAssertEqual(requests[0].query, nil)
            })
            .disposed(by: disposeBag)
    }
}
