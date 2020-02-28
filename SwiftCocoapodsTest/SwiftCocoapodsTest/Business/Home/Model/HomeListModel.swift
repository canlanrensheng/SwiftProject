//
//  HomeListModel.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HomeListModel: NSObject {
    var err: Int?
    var items : [ActivityModel]?
    init(jsonData:JSON) {
        err = jsonData["err"].intValue
        items = jsonData["items"].arrayValue.compactMap { ActivityModel(jsonData: $0) }
    }
}

class ActivityModel: NSObject {
    var origin_url : String = ""
    var content : String = ""
    var state : String = ""
    init(jsonData:JSON) {
        origin_url = jsonData["origin_url"].stringValue
        content = jsonData["content"].stringValue
        state = jsonData["state"].stringValue
    }
}

//class HomeListModel: HandyJSON {
//    var err: Int?
//    var items : [ActivityModel]?
//    required init() {}
//}
//
//class ActivityModel: HandyJSON {
//    let origin_url : String = ""
//    let content : String = ""
//    let state : String = ""
//    required init() {}
//}
