//
//  DetailViewModelTests.swift
//  SideDishWithRxTests
//
//  Created by 양준혁 on 2021/08/25.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import SideDishWithRx

class DetailViewModelTests: XCTestCase {
    private var detailViewModel: DetailViewModel!
    private var sceneCoordinator: SceneCoordinator!
    private var repository: SideDishRepository!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var sideDishAPIStub: SideDishAPIStub!
    private var dish: Dish!

    override func setUp() {
        super.setUp()
        sceneCoordinator = SceneCoordinator(window: UIWindow())
        sideDishAPIStub = SideDishAPIStub()
        repository = SideDishRepository(apiService: sideDishAPIStub)
        dish = Dish(detailHash: "HBDEF", image: "http://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg", alt: "오리 주물럭_반조리", deliveryType: ["새벽배송", "전국택배"], title: "오리 주물럭_반조리", description: "감칠맛 나는 매콤한 양념", nPrice: "15,800원", sPrice: "12,640원", badge: ["런칭특가"])
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        sceneCoordinator = nil
        sideDishAPIStub = nil
        repository = nil
        dish = nil
        detailViewModel = nil
        scheduler = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIncreaseQuantity() {
        // when
        detailViewModel.input.plus.onNext(())
        let quantity = try! detailViewModel.output.quantity.toBlocking().first()
        
        // then
        XCTAssertEqual(quantity!, 2)
    }
    
    func testDecreaseQuantity() {
        // when
        detailViewModel.input.minus.onNext(())
        let quantity = try! detailViewModel.output.quantity.toBlocking().first()
        
        // then
        XCTAssertEqual(quantity!, 1)
    }


}
