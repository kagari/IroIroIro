//
//  SettingController.swift
//  Sample
//
//  Created by 新垣結梨 on 2019/10/31.
//  Copyright © 2019 Yuiri A. All rights reserved.
//

import Foundation
import UIKit

class SettingController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myTableView1: UITableView!
    let textArry: [String] = ["1番めのセル"]

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = 100//UITableView.automaticDimension
        self.view.addSubview(myTableView1)
        
        let backButton = UIButton(frame: CGRect(x: w - 300 , y: h - 100, width: 200, height: 30))
        backButton.setTitle("戻る", for: UIControl.State())
        backButton.setTitleColor(UIColor(red:120/255, green:204/255, blue:208/255, alpha:1), for: UIControl.State())
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 10.0
        backButton.layer.borderColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1).cgColor
        backButton.layer.borderWidth = 1.0
        backButton.addTarget(self, action: #selector(onbackClick2(_:)), for: .touchUpInside)
        view.addSubview(backButton)
        
        
    }
    
    //④セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        print("セクション数：1")
        return 1
    }
    //④セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "設定"
    }
    //④セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("セル数：1")
        return 1
    }
//事例
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "aaa")
        cell.textLabel?.text = "アプリのバージョン"
        cell.detailTextLabel?.text = "1.0"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onbackClick2(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
