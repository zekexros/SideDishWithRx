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
import NSObject_Rx

final class DetailViewModel: HasDisposeBag, ViewModelType {
    struct Input {
        let plus = PublishSubject<Void>()
        let minus = PublishSubject<Void>()
    }
    
    struct Output {
        let detailDish = PublishRelay<DetailDish>()
        let quantity = BehaviorRelay<Int>(value: 1)
        let price: BehaviorRelay<String>
        let images = PublishRelay<Data>()
        let detailImages = PublishRelay<Data>()
    }
    
    var repository: RepositoryType
    var sceneCoordinator: SceneCoordinatorType
    let dish: Dish
    var input = Input()
    lazy var output = Output(price: BehaviorRelay<String>(value: dish.sPrice))
    
    init(sceneCoordinator: SceneCoordinatorType, repository: RepositoryType, model: Dish) {
        self.dish = model
        self.sceneCoordinator = sceneCoordinator
        self.repository = repository
        
        //비즈니스 로직
        input.plus
            .map { [unowned self] _ in
                self.output.quantity.value + 1
            }
        .do (onNext: { [unowned self] value in
            let tempPrice = self.convertStringToInt(price: self.dish.sPrice)
                let price = self.convertIntToWon(price: tempPrice * value) + "원"
                self.output.price.accept(price)
            })
            .bind(to: output.quantity)
            .disposed(by: disposeBag)
        
        input.minus
            .map { [unowned self] _ in
                let value = self.output.quantity.value - 1
                return value < 1 ? 1 : value
            }
        .do (onNext: { [unowned self] value in
            let tempPrice = self.convertStringToInt(price: self.dish.sPrice)
                let price = self.convertIntToWon(price: tempPrice * value) + "원"
                self.output.price.accept(price)
            })
            .bind(to: output.quantity)
            .disposed(by: disposeBag)
    }
    
    func fetchDetailDish() -> Observable<DetailDish> {
        return repository.fetch(path: EndPoint(path: .detail), id: dish.detailHash, decodingType: DetailDish.self)
    }

    func fetchImages() -> Observable<Data> {
        return output.detailDish.asObservable()
            .flatMap { Observable.from($0.data.thumbImages) }
            .compactMap{ URL(string: $0) }
            .flatMap { self.repository.fetch(url: $0) }
    }
    
    func fetchDetailImages() -> Observable<Data> {
        return output.detailDish.asObservable()
            .flatMap { Observable.from($0.data.detailSection) }
            .compactMap{ URL(string: $0) }
            .flatMap { self.repository.fetch(url: $0) }
    }

    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animation: true).asObservable().map { _ in }
    }
    
    private func convertStringToInt(price: String) -> Int {
        return Int(price.filter{ $0.isNumber }) ?? 0
    }
    
    private func convertIntToWon(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: price)) ?? "" + "원"
        return result
    }
}
