//
//  MarketListViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit

class MarketListViewController: UIViewController,MarketListViewModelDelegate {

    @IBOutlet weak var tblMarketList: UITableView!
    var viewModel: MarketListViewModel = MarketListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MarketListViewModel.init()
        viewModel.delegate = self
        viewModel.load(view: self.view)
        viewModel.getData()
        tblMarketList.register(UINib.init(nibName: "MarketTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "marketCell")
    }
    
    func handleViewModelOutput(_ output: MarketListModalViewModelOutput) {
        switch output {
        case .isErrorConnection( _):
            print("Internet connection error message")
        case .reloadData:
            DispatchQueue.main.async {
                self.tblMarketList.reloadData()
            }
        case .updateTitle(let title):
            self.title = title
        }
    }
}

extension MarketListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MarketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "marketCell", for: indexPath) as! MarketTableViewCell
        cell.item = viewModel.arrayList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MarketModulStoryboard", bundle: nil)
        let vc:MarketDetailViewController = storyboard.instantiateViewController(withIdentifier:"marketDetail") as! MarketDetailViewController
        vc.detailID = viewModel.arrayList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

