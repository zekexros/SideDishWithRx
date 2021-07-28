//
//  TransitionModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation

enum TransitionStyle {
    case root
    case push
}

enum TransitionError: Error {
    case navigationControllerMissing
    case unknown
}
