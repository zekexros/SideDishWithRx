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

class SideDishAPIStub: APIType {
    func requestWithHashID<T>(path: EndPoint, id: String?, decodingType: T.Type) -> Observable<T> where T : Decodable {
        var sampleData: Data {
            Data(
                """
                aa
                """.utf8
            )
        }
        var data = NSDataAsset(name: "")
        switch path.path {
        case .mainDish:
            data = NSDataAsset(name: "MainDish")!
        case .sideDish:
            data = NSDataAsset(name: "SideDish")!
        case .soup:
            data = NSDataAsset(name: "Soup")!
        case .detail:
            break
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try! jsonDecoder.decode(decodingType, from: data!.data)
        return Observable<T>.just(decoded)
    }
    
    func request(url: URL) -> Observable<Data> {
        
        return Observable<Data>.just(Data(base64Encoded: "")!)
    }
}

class MainViewModelTests: XCTestCase {
    private var mainViewModel: MainViewModel!
    private var sceneCoordinator: SceneCoordinator!
    private var repository: SideDishRepository!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var sideDishAPIStub: SideDishAPIStub!

    override func setUp() {
        super.setUp()
        sceneCoordinator = SceneCoordinator(window: UIWindow())
        sideDishAPIStub = SideDishAPIStub()
        repository = SideDishRepository(apiService: sideDishAPIStub)
        mainViewModel = MainViewModel(sceneCoordinator: sceneCoordinator, repository: repository)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDishes() throws {
        // when
        
        let result = try! mainViewModel.fetchDishes().toBlocking().first()
        
        // then
        XCTAssert(!result!.isEmpty, "데이터가 존재합니다.")
    }
}
