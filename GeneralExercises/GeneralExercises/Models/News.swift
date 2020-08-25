//
//  News.swift
//  GeneralExercises
//
//  Created by Van Khanh Vuong on 8/21/20.
//  Copyright © 2020 IMT. All rights reserved.
//

import Foundation

struct News:Decodable {
    let index:Int
    let tagImage:String
    let pictureNew:String
    let titleNew:String
    let contentNew:String
    let trend:String
    
    
    
    var tagNews:String{return "#\(tagImage)"}
}

