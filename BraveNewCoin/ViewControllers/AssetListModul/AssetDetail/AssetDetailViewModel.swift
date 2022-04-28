//
//  AssertDetailViewModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit


protocol AssetDetailViewModelProtocol {
    var delegate: AssetDetailViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol AssetDetailViewModelDelegate {
    func handleViewModelOutput(_ output: AssetDetailModalViewModelOutput)
}

enum AssetDetailModalViewModelOutput: Equatable {
    case updateTitle(String)
    case reloadUI
    case isErrorConnection(String)
}

class AssetDetailViewModel: UIViewController {

    var delegate: AssetDetailViewModelDelegate?
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)

    var assetObject:AssetDetailModel!
    
    func load(view: UIView) {
        notify(.updateTitle("Asset Detail"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: AssetDetailModalViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func getData(assetID:String)
    {
        showHideIndicator(isStart: true)
        networkHelper?.getAssetDetail(assetID:assetID,complation: {
            result in
            switch result
            {
            case .success(let response):
                self.setupUI(mObject: response)
                self.showHideIndicator(isStart: false)
                self.notify(.reloadUI)
            case .failure(let error):
                print("error \(error)")
            case .timeOutFailure(let timeoutError):
                print("timeoutError \(timeoutError)")
            }
        })
    }

    func setupUI(mObject:AssetDetailModel){
        assetObject = mObject
    }
    
    func pushViewController(view:UIViewController,storyboard:String,viewID:String,isAnimated:Bool)
    {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let presentScren = storyboard.instantiateViewController(withIdentifier:viewID)
        view.navigationController?.pushViewController(presentScren, animated: true)
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

