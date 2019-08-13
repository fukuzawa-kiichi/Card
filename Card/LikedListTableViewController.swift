//
//  LikedListTableViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class LikedListTableViewController: UITableViewController {

    // いいね」された名前の一覧
    var likedName: [String] = []
    // 「いいね」をされた人の職業の配列
    var likedNameJob: [String] = []
    // 「いいね」をされた人の出身地の配列
    var likedNameBirth: [String] = []

    @IBOutlet weak var infoList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       infoList.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - Table view data source

    // 必須:セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedName.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    // 必須:セルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        // いいねされた名前を表示
        cell.personName.text = likedName[indexPath.row]
        // いいねされた人の職業
        cell.personJob.text = likedNameJob[indexPath.row]
        // いいねされた人の出身地
        cell.personBirth.text = likedNameBirth[indexPath.row]
        // いいねされた人の写真
        cell.picture.image = UIImage(named: likedName[indexPath.row])
        return cell
    }

}
