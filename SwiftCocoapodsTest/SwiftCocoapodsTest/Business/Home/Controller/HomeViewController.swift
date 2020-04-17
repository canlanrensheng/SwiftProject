//
//  HomeViewController.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
//import HandyJSON
import Alamofire
import Kingfisher
import SwiftyJSON

typealias AddNumber = (Int,Int) -> Void

class HomeViewController: BaseViewController {
    
    var publishButton : UIButton = {
        let button = JSButton.createButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30), imageName: "ic_publish") {
            
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitle("发布", for: UIControl.State.normal)
        button.setTitleColor(HexColor(rgbValue: 0x333333), for: UIControl.State.normal)
        button.setButtonWithEdgeInsetsStyle(edgeStyle: ButtonLayoutStyle.ButtonLayoutStyleImagePositionRight, space: 10)
        return button
    }()
    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.publishButton)
        
        self.view.addSubview(self.tableView)
        self.headerRefresh()
        
        //下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.headerRefresh();
        })
        
        //上拉加载
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.footerRefresh()
        })

    }
    
    //懒加载数组
    lazy var dataArray : Array<Any> = {
        var array = Array<Any>()
        return array
    }()
    
    //懒加载tableView
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: (KScreenHeight - 49 - 64)), style: UITableView.Style.plain)
        tableView.register(SwiftTableViewCell.classForCoder(), forCellReuseIdentifier: "SwiftTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        return tableView
    }()

    @objc func headerRefresh() -> Void {
        self.refreshData(page: 1)
    }
    
    @objc func footerRefresh() -> Void {
        self.refreshData(page: self.page + 1)
    }
    
    @objc func refreshData(page : NSInteger) -> Void {
        if page == 1 {
            self.showHUD()
        }
        let url = homeList
        let parameters = ["page" : page]
        HttpTool.manager.requestData(method: .get, path: url, parameters: parameters, success: { (data) in
            self.hideHUD()
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            let dataDict  = data as! JSON
            let model = HomeListModel.init(jsonData: dataDict)
            
        }) { (errorCode, errorDesc) in
            self.showHUDMessage(errorDesc)
        }
       
//        HttpTool.shareInstance.requestData(.get, urlString: url, parameters: ["page" : page as AnyObject], success: { (result) in
////            WisdomHUD.dismiss()
//            self.hideHUD()
//            self.tableView.mj_header?.endRefreshing()
//            let dict = result["data"] as? [String : Any]
////            let model = HomeListModel.deserialize(from: result as? Dictionary)
//            let jsonData = JSON(result)
//            let model = HomeListModel.init(jsonData:jsonData)
//            if page == 1 {
//                self.dataArray = model.items!
//            } else {
//                self.dataArray.append(contentsOf:model.items!)
//                self.tableView.mj_footer?.endRefreshing()
//                self.page += 1
//            }
////            if page == 1 {
////                self.dataArray = model!.items!
////            } else {
////                self.dataArray.append(contentsOf: model!.items!)
////                self.tableView.mj_footer?.endRefreshing()
////                self.page += 1
////            }
////            self.showHUDMessage("加载成功")
//            self.tableView.reloadData()
//            print(result)
//        }) { (NSError) in
//            self.tableView.mj_header?.endRefreshing()
//            self.tableView.mj_footer?.endRefreshing()
//            print(NSError.error.debugDescription)
//        }
    }
}

extension HomeViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.mj_footer!.isHidden = self.dataArray.count == 0
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SwiftTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SwiftTableViewCell", for: indexPath) as! SwiftTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        if indexPath.row < self.dataArray.count {
//            let model  = (self.dataArray[indexPath.row] as? ActivityModel)!
//            cell.nameLabel.text = model.state
//            cell.contentLabel.text = model.content
//            cell.iconImageView.kf.setImage(with: URL(string: model.origin_url), placeholder:nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        return cell
    }
}

extension HomeViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController :DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无数据"
        let attributes = [NSAttributedString.Key.font: RegularFont(size: 15), NSAttributedString.Key.foregroundColor: TextColor]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return tableViewBackGroundColor
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "img_empty_news")
        return image
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 10
    }
}

extension HomeViewController :DZNEmptyDataSetDelegate{
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
