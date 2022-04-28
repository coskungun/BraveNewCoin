//
//  AssetListViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit

class AssetListViewController: UIViewController,AssetListViewModelDelegate {
    
    @IBOutlet weak var tblAssetLists: UITableView!
    var viewModel: AssetListViewModel = AssetListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AssetListViewModel.init()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.getData()
        tblAssetLists.register(UINib.init(nibName: "AssetListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "assetCell")
    }
    
    func handleViewModelOutput(_ output: AssetListModalViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadData:
            DispatchQueue.main.async {
                self.tblAssetLists.reloadData()
            }
        case .updateTitle(let title):
            self.title = title
        }
    }
}

extension AssetListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AssetListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "assetCell", for: indexPath) as! AssetListTableViewCell
        cell.item = viewModel.arrayList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "AssetModulStoryboard", bundle: nil)
        let vc:AssetDetailViewController = storyboard.instantiateViewController(withIdentifier:"assetDetail") as! AssetDetailViewController
        vc.detailID = viewModel.arrayList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
