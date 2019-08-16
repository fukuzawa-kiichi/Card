//
//  ViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // viewの動作をコントロールする
    @IBOutlet weak var baseCard: UIView!
    // スワイプ中にgood or bad の表示
    @IBOutlet weak var likeImage: UIImageView!
    // ユーザーカード1
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person1Img: UIImageView!
    @IBOutlet weak var person1NameLabel: UILabel!
    @IBOutlet weak var person1JobLabel: UILabel!
    @IBOutlet weak var person1BirthLabel: UILabel!
    // ユーザーカード2
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person2Img: UIImageView!
    @IBOutlet weak var person2NameLabel: UILabel!
    @IBOutlet weak var person2JobLabel: UILabel!
    @IBOutlet weak var person2BirthLabel: UILabel!
    
    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    // 1枚目と２枚目のどっちに入れるか
    var selectedCardCount: Int = 0
    // 次に表示されてる人のリストの番目
    var nextUserNum:Int = 2
    // 現在表示されている人のリストの番号
    var nowUserNum:Int = 0
    // ユーザーリスト
    let userList: [userData] = [
        userData(name: "津田梅子", image: #imageLiteral(resourceName: "津田梅子"), job: "教師", birth: "千葉", backColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        userData(name: "ジョージ・ワシントン", image: #imageLiteral(resourceName: "ジョージワシントン"), job: "大統領", birth: "アメリカ", backColor: #colorLiteral(red: 0.9943607436, green: 1, blue: 0.6103758936, alpha: 1)),
        userData(name: "ガリレオ・ガリレイ", image: #imageLiteral(resourceName: "ガリレオガリレイ"), job: "物理学者", birth: "イタリア", backColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
        userData(name: "板垣退助", image: #imageLiteral(resourceName: "板垣退助"), job: "議員", birth: "高知", backColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
        userData(name: "ジョン万次郎", image: #imageLiteral(resourceName: "ジョン万次郎"), job: "冒険家", birth: "アメリカ", backColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
    ]
    // 「いいね」をされた名前の配列
    var likedName: [String] = []
    
    // viewのレイアウト処理が完了した時に呼ばれる
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    // ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        // personListにperson1、2を追加
        personList.append(person1)
        personList.append(person2)
    }
    
    // セグエによる遷移前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedListTableViewController
            
            vc.likedName = likedName
        }
    }
    
    // user1の情報をそれぞれ入れる
    func user1 (num: Int) {
        let user = userList[num]
        person1.backgroundColor = user.backColor
        person1Img.image = user.image
        person1NameLabel.text = user.name
        person1JobLabel.text = user.job
        person1BirthLabel.text = user.birth
    }
    
    // user2の情報をそれぞれ入れる
    func user2 (num: Int) {
        let user = userList[num]
        person2.backgroundColor = user.backColor
        person2Img.image = user.image
        person2NameLabel.text = user.name
        person2JobLabel.text = user.job
        person2BirthLabel.text = user.birth
    }
    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
    override func viewDidDisappear(_ animated: Bool) {
        // カウント初期化
        selectedCardCount = 0
        nextUserNum = 2
        nowUserNum = 0
        // リスト初期化
        likedName = []
        
        // ビュー2枚目を整理
        self.view.sendSubviewToBack(person2)
        // alpha値をもとに戻す
        person1.alpha = 1
        person2.alpha = 1
        // ビューの初期化
        // 1枚目
        self.user1(num: nowUserNum)
        // 2枚目(0番目の次)
        self.user2(num: nowUserNum + 1)
    }
    
    // ベースカードを元に戻す
    func resetCard() {
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
    }
    
    
    // カードを飛ばす処理
    func skipCard(distance: CGFloat) {
        personList[selectedCardCount].center = CGPoint(x: personList[selectedCardCount].center.x + distance, y: personList[selectedCardCount].center.y)
        // ベースカードのリセット
        resetCard()
    }
    
    // カードを次のにする処理
    func nextPersonList() {
        // 背面にカードを持ってくる
        self.view.sendSubviewToBack(personList[selectedCardCount])
        // 中心に持ってくいる
        personList[selectedCardCount].center = centerOfCard
        personList[selectedCardCount].transform = .identity
        // 3枚目以降に新しいデータを入れていく
        if nextUserNum < userList.count {
            selectCard()
        }else {
            // 板垣退助を隠す
            person2.alpha = 0
        }
        // 次のカードへ行く
        nowUserNum += 1
        nextUserNum += 1
        if nowUserNum >= userList.count {
            // すべて終わったときに画面を真っ白にする
            person1.alpha = 0
            // 画面遷移
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
        // どっちのカードに入れるかを決める数字
        selectedCardCount = nowUserNum % 2
    }
    
    // どっちのカードに入れるか
    func selectCard() {
        // 0なら一枚目
        if selectedCardCount == 0 {
            user1(num: nextUserNum)
        }else{
            user2(num: nextUserNum)
        }
    }
    // スワイプ処理
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        // ベースカード
        let card = sender.view!
        // 動いた距離
        let point = sender.translation(in: view)
        // 取得できた距離をcard.centerに加算
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        // ユーザーカードにも同じ動きをさせる
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        // 元々の位置と移動先との差
        let xfromCenter = card.center.x - view.center.x
        // 角度をつける処理
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        // ユーザーカードに角度をつける
        personList[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        // likeImageの表示のコントロール
        if xfromCenter > 0 {
            // goodを表示
            likeImage.image = #imageLiteral(resourceName: "いいね")
            likeImage.isHidden = false
        } else if xfromCenter < 0 {
            // badを表示
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            likeImage.isHidden = false
        }
        
        // 元の位置に戻す処理
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.5, animations: {
                    // 左へ飛ばす場合
                    // X座標を左に500とばす(-500)
                    self.skipCard(distance: -500)
                })
                // likeImageを隠す
                likeImage.isHidden = true
                nextPersonList()
                
            } else if card.center.x > self.view.frame.width - 50 {
                // 右に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.5, animations: {
                    // 右へ飛ばす場合
                    // X座標を右に500とばす(+500)
                    self.skipCard(distance: 500)
                })
                // likeImageを隠す
                likeImage.isHidden = true
                // いいねリストに追加
                likedName.append(userList[nowUserNum].name)
                // 次のカードへ
                nextPersonList()
                
            } else {
                // アニメーションをつける
                UIView.animate(withDuration: 0.5, animations: {
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードの角度を元の位置に戻す
                    self.personList[self.selectedCardCount].transform = .identity
                    // ベースカードの角度と位置を戻す
                    self.resetCard()
                    // likeImageを隠す
                    self.likeImage.isHidden = true
                })
            }
        }
    }
    
    // よくないねボタン
    @IBAction func dislikedButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            // X座標を左に500とばす(-500)
            self.skipCard(distance: -500)
        })
        // 連打の防止
        sender.isEnabled = false
        // 0.2秒後に次のカードを表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            // 次の画面を表示
            self.nextPersonList()
            sender.isEnabled = true
        })
    }
    
    // いいねボタン
    @IBAction func likedButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            // X座標を左に500とばす(500)
            self.skipCard(distance: 500)
        })
        // いいねリストに追加
        likedName.append(userList[nowUserNum].name)
        // 連打の防止
        sender.isEnabled = false
        // 0.2秒後に次のカードを表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            // 次の画面を表示
            self.nextPersonList()
            sender.isEnabled = true
        })
    }
}

