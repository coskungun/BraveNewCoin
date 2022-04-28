//
//  ViewController.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import UIKit

class ChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func createTokenClick(_ sender: Any) {
        print("createToken")
        pushViewController(storyboardIdentifier: "Main", vc:CreateTokenViewController() , identifierName: "createToken")
    }
    @IBAction func marketListClick(_ sender: Any) {
        pushViewController(storyboardIdentifier: "MarketModulStoryboard",vc:CreateTokenViewController() , identifierName: "marketList")
    }
    
    @IBAction func assetListClick(_ sender: Any) {
        pushViewController(storyboardIdentifier: "AssetModulStoryboard",vc:CreateTokenViewController() , identifierName: "assetList")
    }
    
    func pushViewController(storyboardIdentifier:String,vc:UIViewController,identifierName:String) {
        let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
        let pushScreen = storyboard.instantiateViewController(withIdentifier:identifierName)
        self.navigationController?.pushViewController(pushScreen, animated: true)
    }
    
}

