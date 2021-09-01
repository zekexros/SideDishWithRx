//
//  CommonViewModel.swift
//  SideDishWithRx
//
//  Created by zeke on 2021/07/29.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    var sceneCoordinator: SceneCoordinatorType { get }
    var repository: RepositoryType { get }
}
