//
//  BaseNavViewController.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航条的背景颜色
        UINavigationBar.appearance().barTintColor = UIColor.white
        //设置导航条不半透明
        self.navigationBar.isTranslucent = false
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1 {
            viewController.navigationItem.hidesBackButton = true
            viewController.navigationItem.setLeftBarButton(self.createLeftBar(), animated: true)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    
    func createLeftBar() -> UIBarButtonItem {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(UIImage.init(named: "返回 黑"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backClick), for: UIControl.Event.touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
    
    @objc func backClick() {
        self.popViewController(animated: true)
    }

}
