//
//  CreateTokenViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit


class CreateTokenViewController: UIViewController,CreateTokenViewModelDelegate {
 
    @IBOutlet weak var lblToken: UILabel!
    var viewModel: CreateTokenViewModel = CreateTokenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateTokenViewModel.init()
        viewModel.delegate = self
        viewModel.load(view: self.view)
    }
    
    
    func handleViewModelOutput(_ output: CreateModalViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadData:
            print("return data")
        case .updateTitle(let title):
            self.title = title
        case .updateTokenText(let token):
            self.lblToken.text = token
        }
    }
    
    
    @IBAction func generateTokenClick(_ sender: Any) {
        viewModel.getCreateToken()
    }
}
