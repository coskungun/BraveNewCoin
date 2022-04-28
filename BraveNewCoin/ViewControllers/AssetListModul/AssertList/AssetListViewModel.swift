//
//  AssetListViewModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit

protocol AssetListViewModelProtocol {
    var delegate: AssetListViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol AssetListViewModelDelegate {
    func handleViewModelOutput(_ output: AssetListModalViewModelOutput)
}

enum AssetListModalViewModelOutput: Equatable {
    case updateTitle(String)
    case reloadData
    case isErrorConnection(String)
}

class AssetListViewModel:AssetListViewModelProtocol
{
    var delegate: AssetListViewModelDelegate?
    var arrayList:[ArrAssetContentList] = Array.init()
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)
    
    func load(view: UIView) {
        notify(.updateTitle("Asset List"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: AssetListModalViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func getData()
    {
        showHideIndicator(isStart: true)
        networkHelper?.getAllAssetData(complation: {
            result in
            switch result
            {
            case .success(let response):
                self.arrayList = response.content ?? Array.init()
                self.showHideIndicator(isStart: false)
                self.notify(.reloadData)
            case .failure(let error):
                print("error \(error)")
            case .timeOutFailure(let timeoutError):
                print("timeoutError \(timeoutError)")
            }
        })
    }


    public func showHideIndicator(isStart:Bool)
    {
        if isStart == true
        {
            spinner.startAnimating()
        }else
        {
            spinner.stopAnimating()
        }
    }
}
