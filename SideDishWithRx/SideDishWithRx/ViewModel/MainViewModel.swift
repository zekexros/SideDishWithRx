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
import NSObject_Rx

final class MainViewModel: HasDisposeBag, ViewModelType {
    
    var input = Input()
    var output = Output()
    var sceneCoordinator: SceneCoordinatorType
    var repository: RepositoryType
    

    init(sceneCoordinator: SceneCoordinatorType, repository: RepositoryType) {
        self.repository = repository
        self.sceneCoordinator = sceneCoordinator
        
        // 비즈니스 로직
        input.isViewDidLoad
            .filter { $0 }
            .flatMap { _ in
                self.fetchDishes()
            }
            .catchAndReturn([])
            .bind(to: output.sections)
            .disposed(by: disposeBag)
            
    }
    
    struct Input {
        let isViewDidLoad = BehaviorRelay<Bool>(value: false)
    }
    
    struct Output {
        let sections = PublishRelay<[SectionOfCustomData]>()
    }
    
    lazy var transitionAction: Action<Dish, Void> = {
        return Action { dish in
            let detailViewModel = DetailViewModel(sceneCoordinator: self.sceneCoordinator, repository: self.repository, model: dish)
            let detailScene = Scene.detail(detailViewModel)
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
    func fetchDishes() -> Observable<[SectionOfCustomData]> {
        let mainDish = repository.fetchDish(endPoint: EndPoint(path: .mainDish))
        
        let sideDish = repository.fetchDish(endPoint: EndPoint(path: .sideDish))
        
        let soup = repository.fetchDish(endPoint: EndPoint(path: .soup))
        
        return Observable.combineLatest([mainDish, sideDish, soup], resultSelector: { dishes -> [SectionOfCustomData] in
            let dishes = [
                SectionOfCustomData(header: SectionHeader.mainDish.value, items: dishes[0]),
                SectionOfCustomData(header: SectionHeader.sideSide.value, items: dishes[1]),
                SectionOfCustomData(header: SectionHeader.soup.value, items: dishes[2])
            ]
            return dishes
        })
    }
}
