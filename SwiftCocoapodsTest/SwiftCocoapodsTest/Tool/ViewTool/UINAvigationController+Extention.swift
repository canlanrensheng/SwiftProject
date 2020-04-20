//
//  UINAvigationController+Extention.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/20.
//  Copyright © 2020 张金山. All rights reserved.
//

import Foundation

extension UINavigationController {
    /// Pop view controller
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func popViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// Push view controller
    /// - Parameters:
    ///   - viewController: 想要push的viewController
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
