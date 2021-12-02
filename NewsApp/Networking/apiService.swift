//
//  apiService.swift
//  TaqeemTeacher
//
//  Created by ADEL ELGAZAR on 4/14/20.
//  Copyright © 2020 ADEL ELGAZAR. All rights reserved.
//

import Moya

enum apiService {
    case getTopHeadlines(country:String, category:String)
}

// MARK: - TargetType Protocol Implementation
extension apiService: TargetType {
    var baseURL: URL { return URL(string: K_API_URL)! }
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "/top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTopHeadlines:
            return .get
        default:
            return .post
        }
    }
    
    
    var parameters: [String: Any]? {
        switch self {
        // Authentication
        case .getTopHeadlines(let country, let category):
            var parameters = [String: Any]()
            parameters["apiKey"] = K_API_KEY
            parameters["country"] = country
            parameters["category"] = category
            return parameters
            
        default:
            return [String: Any]()
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .getTopHeadlines:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
            
        default:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
//        print("\(K_Defaults.string(forKey: Saved.token) ?? "")")
        var parameters = [String: String]()
//        if !"\(K_Defaults.string(forKey: Saved.token) ?? "")".isEmpty {
//            parameters["Authorization"] = "Bearer \(K_Defaults.string(forKey: Saved.token) ?? "")"
//        }
        parameters["accept"] = "text/plain"
        parameters["Content-Type"] = "application/json"
        
        return parameters
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
