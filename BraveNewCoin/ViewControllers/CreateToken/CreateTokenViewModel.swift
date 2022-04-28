//
//  CreateTokenViewModel.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import UIKit

protocol CreateTokenViewModelProtocol {
    var delegate: CreateTokenViewModelDelegate? { get set }
    func load(view:UIView)
}

protocol CreateTokenViewModelDelegate {
    func handleViewModelOutput(_ output: CreateModalViewModelOutput)
}

enum CreateModalViewModelOutput: Equatable {
    case updateTitle(String)
    case updateTokenText(String)
    case reloadData
    case isErrorConnection(String)
}

class CreateTokenViewModel:CreateTokenViewModelProtocol
{
    var delegate: CreateTokenViewModelDelegate?
    var networkHelper:NetworkHelper? = NetworkHelper() //network operation -> optional (isteğe bağlı)
    var spinner = UIActivityIndicatorView.init(style: .large)
    
    func load(view: UIView) {
        notify(.updateTitle("Create Token"))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func notify(_ output: CreateModalViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
        
    func getCreateToken()
    {
        showHideIndicator(isStart: true)
        networkHelper?.getCreateTokenRequest(complation: {
            result in
            switch result
            {
            case .success(let response):
                self.notify(.updateTokenText(response.access_token ?? ""))
                self.showHideIndicator(isStart: false)
            case .failure(let error):
                print("error \(error)") //error toast or alert
                self.showHideIndicator(isStart: false)
            case .timeOutFailure(let timeoutError):
                print("timeoutError \(timeoutError)") //error toast or alert
            }
        })
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
