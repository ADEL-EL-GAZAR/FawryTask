//
//  Constants.swift
//  Deliy
//
//  Created by Youm7 on 10/2/17.
//  Copyright © 2017 binshakerr. All rights reserved.
//

import UIKit

let K_Main_URL = "https://newsapi.org"
let K_API_URL = K_Main_URL + "/v2"
let K_Device_ID = UIDevice.current.identifierForVendor!.uuidString
let K_Defaults = UserDefaults.standard
let K_Notifications = NotificationCenter.default
let K_AppDelegate = UIApplication.shared.delegate as! AppDelegate
let K_Parse_Error = "Something is not correct, please try again later"
let K_Server_Error = "Something happened. Please try again later"
let K_Invalid_Access = "يرجى تسجيل الدخول اولا لاتمام العملية"
let K_API_KEY = "f7d110ee301748c28b281d4b094b837a"
//var timer:Timer?
//var minutes = Array(1...59).map { "\($0)" }
var K_Network = NetworkRequest()
//var K_CollectionCellWidth = (UIScreen.main.bounds.width/2)-12
//var K_CollectionCellHeight = (K_CollectionCellWidth*4)/3
//var K_TabCellWidth = 100
//var K_TabCellHeight = 44

enum Saved { //keys of userDefaults
    static let countryCode = "countryCode"
    static let category = "category"
    static let lastUpdateDate = "lastUpdateDate"
}

enum StoryBoards {
    case Main

    var storyboard: UIStoryboard {
        switch self {
        case .Main:
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    func viewController(identifier: String) -> UIViewController {
        return self.storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
