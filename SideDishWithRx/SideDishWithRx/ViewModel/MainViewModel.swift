//
//  MainViewModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RxDataSources

class MainViewModel: CommonViewModel {
    var mainDishList = PublishSubject<[Dish]>()
    var soupList = PublishSubject<[Dish]>()
    var sideDishList = PublishSubject<[Dish]>()
    var sections = PublishRelay<[SectionOfCustomData]>()
    
    var apiService: APIType
    
    init(sceneCoordinator: SceneCoordinatorType, apiService: APIType) {
        self.apiService = apiService
        super.init(sceneCoordinator: sceneCoordinator)
    }
    
    lazy var transitionAction: Action<Dish, Void> = {
        return Action { dish in
            let detailViewModel = DetailViewModel(sceneCoordinator: self.sceneCoordinator)
            let detailScene = Scene.detail(detailViewModel)

            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
    func fetchDishes() {
        apiService.fetchDish(path: .mainDish)
            .subscribe(mainDishList)
            .disposed(by: rx.disposeBag)
        
        apiService.fetchDish(path: .sideDish)
            .subscribe(sideDishList)
            .disposed(by: rx.disposeBag)
        
        apiService.fetchDish(path: .soup)
            .subscribe(soupList)
            .disposed(by: rx.disposeBag)
        
        Observable.combineLatest([mainDishList, sideDishList, soupList], resultSelector: { dishes -> [SectionOfCustomData] in
            let dishes = [
                SectionOfCustomData(header: "메인", items: dishes[0]),
                SectionOfCustomData(header: "반찬", items: dishes[1]),
                SectionOfCustomData(header: "스프", items: dishes[2])
            ]
            return dishes
        })
        .subscribe(onNext: { [unowned self] dishes in
            self.sections.accept(dishes)
        })
        .disposed(by: rx.disposeBag)
    }
}
