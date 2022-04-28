//
//  Constant.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import Alamofire
struct Constant
{
    
    static let API_URL = "https://bravenewcoin.p.rapidapi.com"
    static let REQUEST_TIMEOUT:TimeInterval = 30;
    static let REQUEST_CREATE_TOKEN:String = "/oauth/token";
    static let REQUEST_MARKET:String = "/market";
    static let REQUEST_ASSET:String = "/asset";
    static let REQUEST_ASSETS_ACTIVE:String = "/asset?status=ACTIVE";
    
    
    
}

let headersCallPost :HTTPHeaders = [
    "content-type": "application/json",
    "X-RapidAPI-Host": "bravenewcoin.p.rapidapi.com",
    "X-RapidAPI-Key": "c09c21c537mshca0c4cd2d683d6fp1fea84jsn24fae9f84f9b"
]
let headersCallGet :HTTPHeaders = [
    "X-RapidAPI-Host": "bravenewcoin.p.rapidapi.com",
    "X-RapidAPI-Key": "c09c21c537mshca0c4cd2d683d6fp1fea84jsn24fae9f84f9b"
]
let parametersCall = [
    "audience": "https://api.bravenewcoin.com",
    "client_id": "oCdQoZoI96ERE9HY3sQ7JmbACfBf55RY",
    "grant_type": "client_credentials"
]
