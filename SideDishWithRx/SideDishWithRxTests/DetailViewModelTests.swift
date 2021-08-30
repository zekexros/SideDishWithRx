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
    private var disposeBag: DisposeBag!
    private var sideDishAPIStub: SideDishAPIStub!
    private var dish: Dish!

    override func setUp() {
        super.setUp()
        sceneCoordinator = SceneCoordinator(window: UIWindow())
        sideDishAPIStub = SideDishAPIStub()
        repository = SideDishRepository(apiService: sideDishAPIStub)
        dish = Dish(detailHash: "HBDEF", image: "http://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg", alt: "오리 주물럭_반조리", deliveryType: ["새벽배송", "전국택배"], title: "오리 주물럭_반조리", description: "감칠맛 나는 매콤한 양념", nPrice: "15,800원", sPrice: "12,640원", badge: ["런칭특가"])
        
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        sceneCoordinator = nil
        sideDishAPIStub = nil
        repository = nil
        dish = nil
        disposeBag = nil
    }

    func testIncreaseQuantity() {
        // given
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        
        // when
        detailViewModel.input.plus.onNext(())
        let quantity = try! detailViewModel.output.quantity.toBlocking().first()
        
        // then
        XCTAssertEqual(quantity!, 2)
    }
    
    func testDecreaseQunatity() {
        // given
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        
        // when
        detailViewModel.input.minus.onNext(())
        let quantity = try! detailViewModel.output.quantity.toBlocking().first()
        
        // then
        XCTAssertEqual(quantity!, 1)
    }
    
    
    func testFetchDetailDish() {
        // given
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        
        // when
        detailViewModel.input.isFetchDetailDish.accept(true)
        
        // then
        sideDishAPIStub.requestParamForDetailDish
            .take(1)
            .subscribe { (url: URL, method: String, query: String?) in
                XCTAssertEqual(url.absoluteString, "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail/HBDEF")
                XCTAssertEqual(method, HTTPMethod.get.rawValue)
                XCTAssertEqual(query, nil)
            }
            .disposed(by: disposeBag)
    }
    
    func testFetchThumbImagesData() {
        // given
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        
        // when
        detailViewModel.input.isFetchThumbImagesData.accept(true)
        
        // then
        sideDishAPIStub.requestParamForDetailDish
            .take(1)
            .subscribe { (url: URL, method: String, query: String?) in
                XCTAssertEqual(url.absoluteString, "http://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg")
                XCTAssertEqual(method, HTTPMethod.get.rawValue)
                XCTAssertEqual(query, nil)
            }
            .disposed(by: disposeBag)
    }
    
    func testFetchDetailSectionImagesData() {
        // given
        detailViewModel = DetailViewModel(sceneCoordinator: sceneCoordinator, repository: repository, model: dish)
        
        // when
        detailViewModel.input.isFetchDetailSectionImagesData.accept(true)
        
        // then
        sideDishAPIStub.requestParamForDetailDish
            .take(1)
            .subscribe { (url: URL, method: String, query: String?) in
                XCTAssertEqual(url.absoluteString, "http://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_D1.jpg")
                XCTAssertEqual(method, HTTPMethod.get.rawValue)
                XCTAssertEqual(query, nil)
            }
            .disposed(by: disposeBag)
    }
}
