//
//  HomeListModel.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeListModel {
    var activityList: [ActivityList]!
    var recommendList: [RecommendList]!
    var hasNextPage: Bool = false
    var noticeList: [NoticeList]!
    var notesBanner: NotesBanner!
    var banner: [Banner]!
    init(jsonData : JSON) {
        activityList = jsonData["activityList"].arrayValue.flatMap { ActivityList(jsonData: $0) }
        recommendList = jsonData["recommendList"].arrayValue.flatMap {RecommendList (jsonData: $0) }
        hasNextPage = jsonData["hasNextPage"].boolValue
        noticeList = jsonData["noticeList"].arrayValue.flatMap { NoticeList(jsonData: $0) }
        notesBanner = NotesBanner(jsonData: jsonData["notesBanner"])
        banner = jsonData["banner"].arrayValue.flatMap { Banner(jsonData: $0) }
    }
}

class ActivityList {
    var coverUrl: String!
    var title: String!
    var activityId: Int = 0
    var width: Int = 0
    var height: Int = 0
    var describe: String!
    init(jsonData : JSON) {
        coverUrl = jsonData["coverUrl"].stringValue
        title = jsonData["title"].stringValue
        activityId = jsonData["coverUrl"].intValue
        width = jsonData["width"].intValue
        height = jsonData["height"].intValue
        describe = jsonData["describe"].stringValue
    }
}

class RecommendList {
    var photoW: Int = 0
    var photoH: Int = 0
    var goodsName: String!
    var goodsId: Int = 0
    var goodsPrice: String!
    var videoUrl: String!
    var mainPhoto: String!
    var goodsType: Int = 0
    init(jsonData : JSON) {
        photoW = jsonData["photoW"].intValue
        photoH = jsonData["photoH"].intValue
        goodsName = jsonData["goodsName"].stringValue
        goodsId = jsonData["goodsId"].intValue
        goodsPrice = jsonData["goodsPrice"].stringValue
        videoUrl = jsonData["videoUrl"].stringValue
        mainPhoto = jsonData["mainPhoto"].stringValue
        goodsType = jsonData["goodsType"].intValue
    }
}
class NoticeList {
    var title: String!
    var type: Int = 0
    var url: String!
    init(jsonData : JSON) {
        title = jsonData["title"].stringValue
        type = jsonData["type"].intValue
        url = jsonData["url"].stringValue
    }
    
}
class NotesBanner {
    var banner: String!
    var circleId: String!
    init(jsonData : JSON) {
        banner = jsonData["banner"].stringValue
        circleId = jsonData["circleId"].stringValue
    }
    
}
class Banner {
    var dataId: String!
    var photoW: Int = 0
    var photoH: Int = 0
    var id: Int = 0
    var returnUrl: String!
    var photoUrl: String!
    var type: Int = 0
    
    init(jsonData : JSON) {
        dataId = jsonData["dataId"].stringValue
        returnUrl = jsonData["returnUrl"].stringValue
        photoUrl = jsonData["photoUrl"].stringValue
        
        photoW = jsonData["photoW"].intValue
        photoH = jsonData["photoH"].intValue
        id = jsonData["id"].intValue
        type = jsonData["type"].intValue
    }
}
