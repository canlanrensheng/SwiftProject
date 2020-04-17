//
//  UserInfoManager.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/4/17.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
    
    static var mageger : UserInfoManager = UserInfoManager()
    
    var userName : String {
        return ""
    }
    
    var userId : String {
        return ""
    }

}
