//
//  MainViewModelTests.swift
//  SideDishWithRxTests
//
//  Created by 양준혁 on 2021/08/18.
//

import XCTest
import RxTest

@testable import SideDishWithRx

class MainViewModelTests: XCTestCase {
    private var mainViewModel: MainViewModel!
    private var sceneCoordinator: SceneCoordinator!
    private var repository: SideDishRepository!
    private var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        sceneCoordinator = SceneCoordinator(window: UIWindow())
        repository = SideDishRepository(apiService: SideDishAPI())
        mainViewModel = MainViewModel(sceneCoordinator: sceneCoordinator, repository: repository)
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
