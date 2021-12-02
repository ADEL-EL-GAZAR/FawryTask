//
//  TeamMember.swift
//  Maly7a-Provider
//
//  Created by Sayed Reda on 2/7/18.
//  Copyright © 2018 hassan. All rights reserved.
//

import Foundation
import Mapper

class ArticleSource:Mappable {
    var id = ""
    var name = ""
    
    required init (map: Mapper) throws {
        id = map.optionalFrom("id") ?? ""
        name = map.optionalFrom("name") ?? ""
    }
}
