//
//  MarketListModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
public struct MarketListModel:Codable{
    let content:[ArrContentList]?
}

public struct ArrContentList:Codable{
    var id:String?
    let baseAssetId:String?
    let quoteAssetId:String?
}
