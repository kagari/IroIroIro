//
//  ViewController.swift
//  EnglishApp
//
//  Created by 大城昂希 on 2019/10/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    // MARK: - UIを整える関数
    private func setupUI() {
        startButton.setTitle("Start", for: UIControl.State.normal)
        // ButtonのtitleLabelの参照を取得
        let startButtonLabel: UILabel = startButton.titleLabel!
        startButtonLabel.textColor = .purple
        startButtonLabel.textAlignment = .center
        startButtonLabel.font = UIFont.systemFont(ofSize: 100.0)
    }

}

