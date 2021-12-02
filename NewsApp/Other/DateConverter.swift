//
//  Date.swift
//  Aqarat
//
//  Created by ADEL on 8/13/17.
//  Copyright © 2017 ADEL. All rights reserved.
//

import Foundation
class DateConverter{
    func convertDateToString(date: NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)
    }
    
    func convertStringToDate(string: String) -> NSDate{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)! as NSDate
    }
    func convertDateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func convertStringToDate(string: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)!
    }
}
