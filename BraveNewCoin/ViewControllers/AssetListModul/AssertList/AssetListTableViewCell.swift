//
//  AssetListTableViewCell.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

class AssetListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblSlugName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblUrl: UILabel!

    var item:ArrAssetContentList?
    {
        didSet
        {
            self.lblID.text = item?.id
            self.lblName.text = item?.name
            self.lblSymbol.text = item?.symbol
            self.lblSlugName.text = item?.slugName
            self.lblStatus.text = item?.status
            self.lblType.text = item?.type
            self.lblUrl.text = item?.url
            
        }
    }
}
