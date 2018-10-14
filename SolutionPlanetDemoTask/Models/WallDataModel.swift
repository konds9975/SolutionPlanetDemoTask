//
//  WallDataModel.swift
//  SolutionPlanetDemoTask
//
//  Created by Kondya on 13/10/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import Foundation
import UIKit

struct PostList:Codable {
    
     var post_list : [WallDataModel]
}

struct WallDataModel : Codable{
    
    var userName : String?
    var firstName : String?
    var lastName : String?
    var postTimeAndDate : String?
    var descrption : String?
    var userProfileImageUrl : String?
    var postImageUrlArray : [String]? = [String]()
    var postVideoUrl : String?
    
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case postTimeAndDate
        case descrption
        case userProfileImageUrl
        case postImageUrlArray
        case postVideoUrl
        case userName = "bhaiKaUserName"
    }
    
}
