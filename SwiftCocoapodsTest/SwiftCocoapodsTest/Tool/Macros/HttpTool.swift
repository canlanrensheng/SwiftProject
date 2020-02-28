//
//  HttpTool.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit
import Alamofire
struct BaseAPI {
    let testApi = ""
    let NormalAPi = ""
}

enum MethodType {
    case get
    case post
    case put
    case delete
}

typealias Success = (_ response: AnyObject) -> Void
typealias Failure = (_ failure : AnyObject) -> Void

class HttpTool: NSObject {
    static let shareInstance  = HttpTool()
//    let headers : HTTPHeaders = HTTPHeaders.ini
    func requestData(_ type : MethodType, urlString : String, parameters : [String : AnyObject]?, success :  @escaping Success, _ failure : @escaping Failure){
        let method : HTTPMethod
        switch type {
        case .get:
            method = .get
            break
        case .post:
            method = .post
            break
        case .put:
            method = .put
            break
        default:
            method = .get
        }
        Alamofire.request(urlString, method: method, parameters: parameters,encoding: URLEncoding.default,headers: nil).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.value as? NSDictionary {
                    success(value)
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
}
