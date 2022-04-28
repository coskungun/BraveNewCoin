//
//  MarketTableViewCell.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

class MarketTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQuoteAssetId: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblBaseAssetId: UILabel!
    var item:ArrContentList?
    {
        didSet
        {
            self.lblID.text = item?.id
            self.lblBaseAssetId.text = item?.baseAssetId
            self.lblQuoteAssetId.text = item?.quoteAssetId
        }
    }
    
}
