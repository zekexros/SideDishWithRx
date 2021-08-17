//
//  DetailViewModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class DetailViewModel: CommonViewModel {
    
    let dish: Dish
    let detailDish = PublishSubject<DetailDish>()
    let quantity = BehaviorRelay<Int>(value: 1)
    lazy var price = BehaviorRelay<String>(value: dish.sPrice)

    
    init(sceneCoordinator: SceneCoordinatorType, repository: RepositoryType, model: Dish) {
        self.dish = model
        super.init(sceneCoordinator: sceneCoordinator, repository: repository)
    }
    
    func fetchDetailDish() {
        repository.fetch(path: EndPoint(path: .detail), id: dish.detailHash, decodingType: DetailDish.self)
            .subscribe(detailDish)
            .disposed(by: rx.disposeBag)
    }

    func fetchImages() -> Observable<Data> {
        return detailDish.asObservable()
            .flatMap { Observable.from($0.data.thumbImages) }
            .compactMap{ URL(string: $0) }
            .flatMap { self.repository.fetch(url: $0) }
    }
    
    func fetchDetailImages() -> Observable<Data> {
        return detailDish.asObservable()
            .flatMap { Observable.from($0.data.detailSection) }
            .compactMap{ URL(string: $0) }
            .flatMap { self.repository.fetch(url: $0) }
    }

    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animation: true).asObservable().map { _ in }
    }
    
    func convertStringToInt(price: String) -> Int {
        return Int(price.filter{ $0.isNumber }) ?? 0
    }
    
    func convertIntToWon(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: price)) ?? "" + "원"
        return result
    }
}
