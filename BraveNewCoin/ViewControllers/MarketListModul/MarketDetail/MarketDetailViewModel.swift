//
//  MarketDetailViewModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

import UIKit

protocol MarketDetailViewModelProtocol {
    var delegate: MarketDetailViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol MarketDetailViewModelDelegate {
    func handleViewModelOutput(_ output: MarketDetailModalViewModelOutput)
}

enum MarketDetailModalViewModelOutput: Equatable {
    case updateTitle(String)
    case reloadUI
    case isErrorConnection(String)
}

class MarketDetailViewModel: UIViewController {

    var delegate: MarketDetailViewModelDelegate?
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)

    var marketObject:MarketDetailModel!
    
    func load(view: UIView) {
        notify(.updateTitle("Market Detail"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: MarketDetailModalViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func getData(marketID:String)
    {
        showHideIndicator(isStart: true)
        networkHelper?.getMarketDetail(marketID:marketID,complation: {
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

    func setupUI(mObject:MarketDetailModel){
        marketObject = mObject
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
