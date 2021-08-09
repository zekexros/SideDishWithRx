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
    
    init(sceneCoordinator: SceneCoordinatorType, repository: RepositoryType, model: Dish) {
        self.dish = model
        super.init(sceneCoordinator: sceneCoordinator, repository: repository)
    }
    
    func fetchDetailDish() {
        repository.fetch(path: EndPoint(path: .detail), id: dish.detailHash)
            .subscribe(with: detailDish)
            .disposed(by: rx.disposeBag)
    }
    
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animation: true).asObservable().map { _ in }
    }
}
