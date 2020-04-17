//
//  HttpTool.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Foundation


struct BaseAPI {
    var baseApiUrl : String = "https://51ysscw.cn/"
    var baseWebUrl : String = "https://51ysscw.cn/"
}

typealias Success = (_ data: AnyObject) -> Void
typealias Failure = (_ errorCode : Int64,_ failureDesc : String) -> Void

class HttpTool: NSObject {
    static let manager = HttpTool()
    func requestData(method: HTTPMethod,path : String,parameters : [String: Any],success:@escaping Success,failure :@escaping Failure) -> Void {
        let url = BaseAPI().baseApiUrl + path
        var header = HTTPHeaders()
        
        request(url, method:method, parameters: parameters, encoding:URLEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    if let data = response.data {
                        let dataDcit = JSON(data)
                        let code = dataDcit["code"].int64!
                        let desc : String = dataDcit["desc"].string!
                        let data  = dataDcit["data"] as! JSON
                        if(code == 0)  {
                            success(data as AnyObject)
                        } else {
                            failure(code,desc)
                        }
                    } else {
                        print("数据解析错误")
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}


