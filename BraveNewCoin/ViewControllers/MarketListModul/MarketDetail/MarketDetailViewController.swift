//
//  MarketDetailViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

class MarketDetailViewController: UIViewController, MarketDetailViewModelDelegate {
    
    @IBOutlet weak var lblQuoteAssetId: UILabel!
    @IBOutlet weak var lblBaseAssetId: UILabel!
    @IBOutlet weak var lblID: UILabel!
    var viewModel: MarketDetailViewModel = MarketDetailViewModel()
    public var detailID:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MarketDetailViewModel.init()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.getData(marketID: self.detailID ?? "")
    }
    
    func handleViewModelOutput(_ output: MarketDetailModalViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadUI:
            reloadUI()
        case .updateTitle(let title):
            self.title = title
        }
    }
    
    func reloadUI(){
        self.lblID.text = viewModel.marketObject.id
        self.lblBaseAssetId.text = viewModel.marketObject.baseAssetId
        self.lblQuoteAssetId.text = viewModel.marketObject.quoteAssetId
    }

}
