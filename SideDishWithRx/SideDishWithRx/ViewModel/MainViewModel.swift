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

class MainViewModel: HasDisposeBag, ViewModelType {
    
    var input = Input()
    var output = Output()
    var sceneCoordinator: SceneCoordinatorType
    var repository: RepositoryType
    

    init(sceneCoordinator: SceneCoordinatorType, repository: RepositoryType) {
        self.repository = repository
        self.sceneCoordinator = sceneCoordinator
        
        fetchDishes()
            .subscribe { [weak self] data in
                self?.output.sections.accept(data)
            }
            .disposed(by: disposeBag)
    }
    
    struct Input {
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
        let mainDish = repository.fetch(path: EndPoint(path: .mainDish), id: nil, decodingType: Dishes.self).map{ $0.body}
        let sideDish = repository.fetch(path: EndPoint(path: .sideDish), id: nil, decodingType: Dishes.self).map{ $0.body}
        let soup = repository.fetch(path: EndPoint(path: .soup), id: nil, decodingType: Dishes.self).map{ $0.body}
        
        return Observable.combineLatest([mainDish, sideDish, soup], resultSelector: { dishes -> [SectionOfCustomData] in
            let dishes = [
                SectionOfCustomData(header: "모두가 좋아하는 든든한 메인요리", items: dishes[0]),
                SectionOfCustomData(header: "정성이 담긴 뜨끈뜨끈 국물요리", items: dishes[1]),
                SectionOfCustomData(header: "식탁을 풍성하게 하는 정갈한 밑반찬", items: dishes[2])
            ]
            return dishes
        })
    }
    
    func fetchImage(url: URL) -> Observable<Data> {
        return repository.fetch(url: url)
    }
    
}
