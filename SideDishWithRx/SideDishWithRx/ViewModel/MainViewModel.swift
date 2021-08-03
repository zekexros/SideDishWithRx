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
    var mainDishList = BehaviorSubject<[Dish]>(value: [])
    var soupList = BehaviorSubject<[Dish]>(value: [])
    var sideDishList = BehaviorSubject<[Dish]>(value: [])
    var sections = BehaviorRelay<[SectionOfCustomData]>(value: [])
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { dataSource, tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath) as? DishTableViewCell else { return UITableViewCell() }
        cell.title.text = item.description
        return cell
    }
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
        
        Observable.combineLatest([mainDishList, sideDishList, soupList], resultSelector: { dishes in
            let dishes = [
                SectionOfCustomData(header: "메인", items: dishes[0]),
                SectionOfCustomData(header: "반찬", items: dishes[1]),
                SectionOfCustomData(header: "스프", items: dishes[2])
            ]
            self.sections.accept(dishes)
        })
        .subscribe()
        .disposed(by: rx.disposeBag)
    }
}
