//
//  AssertDetailModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation

public struct AssetDetailModel:Codable{
    var id:String?
    let name:String?
    let symbol:String?
    let slugName:String?
    let status:String?
    let type:String?
    let url:String?
}
