//
//  NetworkHelpers.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import Alamofire


public enum ApiResult<Value> {
    case success(Value)
    case failure(Error)
    case timeOutFailure(String)
}

public enum Error: Swift.Error {
    case serializationError(internal: Swift.Error)
    case timeRequestError(String)
    case networkError(internal: Swift.Error)
}

protocol NetworkServiceProtocol {
    func getAllAssetData(complation: @escaping (ApiResult<AssetListModel>) -> Void) // n tpinde alınması sağlanabilir.
    
    func getAllMarketData(complation: @escaping (ApiResult<MarketListModel>) -> Void) // n tpinde alınması sağlanabilir.

    func getMarketDetail(marketID:String, complation: @escaping (ApiResult<MarketDetailModel>) -> Void) // n tpinde alınması sağlanabilir.
    
    func getAssetDetail(assetID:String, complation: @escaping (ApiResult<AssetDetailModel>) -> Void) // n tpinde alınması sağlanabilir.

    
    func getCreateTokenRequest(complation: @escaping (ApiResult<CreateTokenModel>) -> Void) // n tpinde alınması sağlanabilir.
    
}
 
public struct NetworkHelper: NetworkServiceProtocol {
   
    func getAssetDetail(assetID: String, complation: @escaping (ApiResult<AssetDetailModel>) -> Void) {
        AF.request(Constant.API_URL+Constant.REQUEST_ASSET+"/\(assetID)",
                method:.get,headers: headersCallGet)
        { urlRequest in urlRequest.timeoutInterval = Constant.REQUEST_TIMEOUT}.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonDecode = try JSONDecoder().decode(AssetDetailModel?.self, from: data!)
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        }
    }
    
    func getAllAssetData(complation: @escaping (ApiResult<AssetListModel>) -> Void) {
        AF.request(Constant.API_URL+Constant.REQUEST_ASSETS_ACTIVE,
                method:.get,headers: headersCallGet)
        { urlRequest in urlRequest.timeoutInterval = Constant.REQUEST_TIMEOUT}.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonDecode = try JSONDecoder().decode(AssetListModel?.self, from: data!)
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        }
    }
    
    func getMarketDetail(marketID: String, complation: @escaping (ApiResult<MarketDetailModel>) -> Void) {
        
        AF.request(Constant.API_URL+Constant.REQUEST_MARKET+"/\(marketID)",
                method:.get,headers: headersCallGet)
        { urlRequest in urlRequest.timeoutInterval = Constant.REQUEST_TIMEOUT}.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonDecode = try JSONDecoder().decode(MarketDetailModel?.self, from: data!)
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        }
    }
    
  
    
    func getAllMarketData( complation: @escaping (ApiResult<MarketListModel>) -> Void) {
     
        AF.request(Constant.API_URL+Constant.REQUEST_MARKET,
                method:.get,headers: headersCallGet)
        { urlRequest in urlRequest.timeoutInterval = Constant.REQUEST_TIMEOUT}.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonDecode = try JSONDecoder().decode(MarketListModel?.self, from: data!)
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        }
        
    }
    
    
    func getCreateTokenRequest(complation: @escaping (ApiResult<CreateTokenModel>) -> Void) {
    
        AF.request(Constant.API_URL+Constant.REQUEST_CREATE_TOKEN,
                   method:.post, parameters:parametersCall, encoder: JSONParameterEncoder.default, headers: headersCallPost)
        { urlRequest in urlRequest.timeoutInterval = Constant.REQUEST_TIMEOUT}.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonDecode = try JSONDecoder().decode(CreateTokenModel?.self, from: data!)
                    {
                        complation(.success(jsonDecode))
                    }
                } catch let error {
                    complation(.failure(.serializationError(internal: error)))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    complation(.timeOutFailure("Timeout request!"))
                default:
                    print("Other error!")
                }
            }
            
        }
    }

}
