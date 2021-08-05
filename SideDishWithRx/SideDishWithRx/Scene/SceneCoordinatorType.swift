//
//  SceneCoordinatorType.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    func close(animation: Bool) -> Completable
}
