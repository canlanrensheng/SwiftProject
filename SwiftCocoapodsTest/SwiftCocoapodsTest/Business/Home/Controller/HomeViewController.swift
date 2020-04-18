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
import SnapKit

typealias AddNumber = (Int,Int) -> Void

class HomeViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    var recommondModel : RecommendList?
    var page = 1
    //懒加载数组
    lazy var dataArray : Array<Any> = {
        var array = Array<Any>()
        return array
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.view.frame.size.width - 24 - 5) / 2.0, height: 171 + 78.5)
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 12, bottom: 8, right: 12)
        var collectionView = UICollectionView.init(frame:CGRect(x: 0, y: 0, width: 0, height: 0) , collectionViewLayout: layout)
        collectionView.register(HomeGoodCollectionViewCell.self, forCellWithReuseIdentifier: "HomeGoodCollectionViewCell")
        collectionView.register(HomeCollectionSectionHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HomeCollectionSectionHeaderView.self))
        collectionView.register(HomeCollectionSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = UIColor.init(red: 242 / 255.0, green: 244 / 255.0, blue: 246 / 255.0, alpha: 1.0)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.headerRefresh()
        
        //下拉刷新
        self.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.headerRefresh();
        })
        
        //上拉加载
        self.collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.footerRefresh()
        })

        self.collectionView.mj_footer?.isHidden = true
    }
    
  

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
        DispatchQueue.global().async {
            HttpTool.manager.requestData(method: .get, path: url, parameters: parameters, success: { (data) in
                self.hideHUD()
                self.collectionView.mj_header?.endRefreshing()
                self.collectionView.mj_footer?.endRefreshing()
                let dataDict  = data as! JSON
                let model = HomeListModel.init(jsonData: dataDict)
                self.dataArray = model.recommendList
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }) { (errorCode, errorDesc) in
                self.showHUDMessage(errorDesc)
            }
        }
       
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeGoodCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeGoodCollectionViewCell", for: indexPath) as! HomeGoodCollectionViewCell
        if indexPath.row < self.dataArray.count {
            cell.loadData(model: self.dataArray[indexPath.row] as! RecommendList)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    //每个分区的内边距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    //最小行间距
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//       return 10;
//    }
    
//    //item 的尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: KScreenWidth / 4.0 - 50 / 4.0, height: KScreenHeight / 4.0 - 50 / 4.0)
//    }
    //每个分区区头尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize (width: KScreenWidth, height: 40)
    }
    
    //返回区尾视图的方法
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
         return CGSize(width: KScreenWidth, height: 40)
    }
    
    //返回区头、区尾实例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            var headview = HomeCollectionSectionHeaderView();
            headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(HomeCollectionSectionHeaderView.self), for: indexPath as IndexPath) as! HomeCollectionSectionHeaderView;
            return headview
        } else {
            var footer = HomeCollectionSectionHeaderView()
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! HomeCollectionSectionHeaderView
            return footer
        }
   }
    
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index is \(indexPath.row)");
        
    }
}


extension HomeViewController :DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无数据"
        let attributes = [NSAttributedString.Key.font: RegularFont(15), NSAttributedString.Key.foregroundColor: TextColor]
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
