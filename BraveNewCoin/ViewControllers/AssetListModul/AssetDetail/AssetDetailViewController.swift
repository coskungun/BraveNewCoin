//
//  AssertDetailViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

class AssetDetailViewController: UIViewController,AssetDetailViewModelDelegate {
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSlugname: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    
    var viewModel: AssetDetailViewModel = AssetDetailViewModel()
    public var detailID:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AssetDetailViewModel.init()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.getData(assetID:self.detailID ?? "")
    }
    
    func handleViewModelOutput(_ output: AssetDetailModalViewModelOutput) {
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
        self.lblID.text = viewModel.assetObject.id
        self.lblName.text = viewModel.assetObject.name
        self.lblType.text = viewModel.assetObject.type
        self.lblUrl.text = viewModel.assetObject.url
        self.lblStatus.text = viewModel.assetObject.status
        self.lblSlugname.text = viewModel.assetObject.slugName
        self.lblSymbol.text = viewModel.assetObject.symbol
        
    }

}
