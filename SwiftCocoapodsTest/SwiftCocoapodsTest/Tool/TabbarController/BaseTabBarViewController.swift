//
//  BaseTabBarViewController.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildVC(childVC: HomeViewController(), title: "首页", normalImageName: "ic_tab_home_normal", selectImageName: "ic_tab_home_selected")
        self.addChildVC(childVC: CircleViewController(), title: "藏友圈", normalImageName: "ic_tab_box_normal", selectImageName: "ic_tab_box_selected")
        self.addChildVC(childVC: LiveViewController(), title: "直播", normalImageName: "ic_tab_live_normal", selectImageName: "ic_tab_live_selected")
        self.addChildVC(childVC: MessageViewController(), title: "消息", normalImageName: "ic_tab_msg_normal", selectImageName: "ic_tab_msg_selected")
        self.addChildVC(childVC: MineViewController(), title: "我的", normalImageName: "ic_tab_mine_normal", selectImageName: "ic_tab_mine_selected")
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        //设置tabar默认的字体的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HexColor(0x979797)], for: UIControl.State.normal)
        //设置tabbar 选中的字体的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : MainColor], for: UIControl.State.selected)
    }
    
    func addChildVC(childVC : UIViewController,title:String,normalImageName : String,selectImageName : String) -> Void {
        let nav = BaseNavViewController.init(rootViewController: childVC)
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: normalImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.addChild(nav)
    }
}
