//
//  StartViewController.swift
//  EnglishApp
//
//  Created by 大城昂希 on 2019/10/31.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    //StartViewDelegateのインスタンスを宣言
    weak var delegate: StartViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = StartView()
    }
}

