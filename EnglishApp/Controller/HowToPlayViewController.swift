//
//  HowToPlayViewController.swift
//  EnglishApp
//
//  Created by 新垣結梨 on 2019/11/04.
//

import Foundation

class HowToPlayViewController: UIViewController, HowToPlayViewDelegate {
    
//    override func viewDidLoad() {
//        print("Called: StartViewController")
//        super.viewDidLoad()
//        let view2 = HowToPlayView()
//        view2.delegate = self
//        self.view2 = view2
//    }
    
    func didTapHowToPlayButton() {
        let howToPlayViewController = HowToPlayViewController()
        howToPlayViewController.modalPresentationStyle = .fullScreen
        self.present(howToPlayViewController, animated: true, completion: nil)
    }
}
