//
//  NetworkRequest.swift
//  ProductiveFamilies
//
//  Created by ADEL ELGAZAR on 10/3/20.
//  Copyright © 2020 ADEL ELGAZAR. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RSLoadingView

class NetworkRequest {
    
    func sendRequest(function:apiService, showLoading:Bool = true, success:@escaping(_ code:String, _ msg:String, _ response :Response)->(), failure:@escaping (_ code:String, _ msg:String, _ response :Response, _ errors:NetworkValidationError?)->()) {
        
        if showLoading {
            RSLoadingView().showOnKeyWindow()
        }
        let provider = MoyaProvider<apiService>()
        provider.request(function) { (result) in
            if showLoading {
                RSLoadingView.hideFromKeyWindow()
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let Dic = try response.mapJSON() as! [String: Any]
                        switch "\(Dic["status"] ?? "")" {
                        case "ok":
                            success("200", "Success", response)
                        default:
                            failure("\(response.statusCode)", "", response, nil)
                        }
                    } catch {
                    }
                case .failure( _):
                    return
                }
            }
        }
    }
}


/// this model is made to handle validation messages from the server
public class NetworkValidationError:Mappable {
    var mobileNumber:[String] = []
    var isMobileNumberValidationRequest:[String] = []
    
    required public init (map: Mapper) throws {
        mobileNumber = map.optionalFrom("$.mobileNumber") ?? []
        isMobileNumberValidationRequest = map.optionalFrom("$.isMobileNumberValidationRequest") ?? []
    }
}
