//
//  AssetListModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
public struct AssetListModel:Codable{
    let content:[ArrAssetContentList]?
}

public struct ArrAssetContentList:Codable{
    let id:String?
    let name:String?
    let symbol:String?
    let slugName:String?
    let status:String?
    let type:String?
    let url:String?
}
