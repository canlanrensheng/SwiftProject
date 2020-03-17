//
//  HttpTool.swift
//  SwiftCocoapodsTest
//
//  Created by 张金山 on 2020/2/26.
//  Copyright © 2020 张金山. All rights reserved.
//

import UIKit

import Alamofire
import Foundation

struct BaseAPI {
    let testApi = ""
    let NormalAPi = ""
}

public enum Method : String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

// typealias NetSuccessBlock<T: Mappable> = (_ value: YBaseModel<T>, JSON) -> Void
typealias FSResponseSuccess = (_ response: [String : Any]) -> Void
typealias FSResponseFail = (_ error: String) -> Void
typealias FSNetworkStatus = (_ NetworkStatus: Int32) -> Void
typealias FSProgressBlock = (_ progress: Int32) -> Void



typealias Success = (_ response: AnyObject) -> Void
typealias Failure = (_ failure : AnyObject) -> Void

class HttpTool: NSObject {
    private var sessionManager : SessionManager?
    static let share = HttpTool()
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        //请求超时时间
        configuration.timeoutIntervalForRequest = 20
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustPolicyManager: nil)
    }
    
     public func getData(url: String,
                        params: [String: Any]?,
                        success: @escaping FSResponseSuccess,
                        error: @escaping FSResponseFail) {
        requestWith(url: url,
                    method: .GET,
                    params: params,
                    success: success,
                    error: error)
    }
    
     public func postData(url: String,
                             params: [String: Any]?,
                             success: @escaping FSResponseSuccess,
                             error: @escaping FSResponseFail) {
//        //根绝业务需求变动
//        //参数拼接url
//        let url = FSRequestData.share.getUrlAddParams(params: params, url: url)
//        //数据进行加密
//        let dic = FSRequestData.share.getReqData(params: params)
        requestWith(url: url,
                    method: .POST,
                    params: params,
                    success: success,
                    error: error)
    }
    
    public func requestWith(url: String,
                                method: Method,
                                params: [String: Any]?,
                                success: @escaping FSResponseSuccess,
                                error: @escaping FSResponseFail) {
            //get
        if method == .GET {
                manageGet(url: url, params: params, success: success, error: error)
            } else {
                managePost(url: url, params: params!, success: success, error: error)
            }
        }
        
        
    
     private func manageGet(url: String,
                               params: [String: Any]?,
                               success: @escaping FSResponseSuccess,
                               error: @escaping FSResponseFail) {
            //请求头信息
            var header = HTTPHeaders()
//            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
            request(url,
                            method: .get,
                            parameters: params,
                            encoding: URLEncoding.default,
                            headers: header).responseJSON { (response) in
                                switch response.result {
                                case .success:
                                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                    success(json ?? "")
                                case .failure:
                                    let statusCode = response.response?.statusCode
                                    error("\(statusCode ?? 0)请求失败")
                                    debugPrint(response.response as Any)
                                }
            }
        }
    
      private func managePost(url: String,
                                    params: [String: Any],
                                    success: @escaping FSResponseSuccess,
                                    error: @escaping FSResponseFail) {
                //请求头信息
                var header = HTTPHeaders()
    //            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
                 request(url,method: .post,
                                parameters: params,
                                encoding: URLEncoding.default,
                                headers: header).responseJSON { (response) in
                                    switch response.result {
                                    case .success:
                                        let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                        success(json ?? "")
                                    case .failure:
                                        let statusCode = response.response?.statusCode
                                        error("\(statusCode ?? 0)请求失败")
                                        debugPrint(response.response as Any)
                                    }
                }
            }
        

}


