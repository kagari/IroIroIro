//
//  SettingController.swift
//  Sample
//
//  Created by 新垣結梨 on 2019/10/31.
//  Copyright © 2019 Yuiri A. All rights reserved.
//

import Foundation
import UIKit


class SettingController: UIViewController {
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let versionLabel = UILabel(frame: CGRect(x: 100, y:200, width: w, height: 50))
            versionLabel.text = "アプリバージョン　\(version) "
            versionLabel.font = UIFont.systemFont(ofSize: 50)
            self.view.addSubview(versionLabel)
        
        //戻るボタン
        let backButton = UIButton(frame: CGRect(x: w - 300 , y: h - 100, width: 200, height: 30))
        backButton.setTitle("戻る", for: UIControl.State())
        backButton.setTitleColor(.orange, for: UIControl.State())
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 10.0
        backButton.layer.borderColor = UIColor.orange.cgColor
        backButton.layer.borderWidth = 1.0
        backButton.addTarget(self, action: #selector(onbackClick2(_:)), for: .touchUpInside)
        view.addSubview(backButton)
        
        
        
        
    }

    @objc func onbackClick2(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
