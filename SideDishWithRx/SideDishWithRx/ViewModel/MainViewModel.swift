//
//  MainViewModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift

class MainViewModel: CommonViewModel {
    var mainDishList: Observable<[MainDish]>?
    var soupList : Observable<[Soup]>?
    var sideDishLish: Observable<[SideDish]>?
}
