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
            .flatMap { [unowned self] _ in
                self.fetchDishes()
            }
            .do(onNext: { [weak self] _ in
                self?.output.isLoading.onNext(false)
            }, onError: { error in
                print("\(error.localizedDescription)-에러 발생")
                let error = error as! Errors
                switch error {
                case .decodingError:
                    self.output.error.onNext(error.rawValue)
                case .networkingError:
                    self.output.error.onNext(error.rawValue)
                }
            }, onCompleted: {
                print("completed되었어요")
            })
            .retry(when: { [unowned self] _ in
                self.input.retryTapped
            })
            .bind(to: output.sections)
            .disposed(by: disposeBag)
        
    }
    
    struct Input {
        let isViewDidLoad = BehaviorRelay<Bool>(value: false)
        let retryTapped = PublishSubject<Void>()
    }
    
    struct Output {
        let sections = PublishRelay<[SectionOfCustomData]>()
        let error = PublishSubject<String>()
        let isLoading = ReplaySubject<Bool>.create(bufferSize: 1)
    }
    
    lazy var transitionAction: Action<Dish, Void> = {
        return Action { [unowned self] dish in
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
