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
    // ユーサーカード2
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person2Img: UIImageView!
    @IBOutlet weak var person2NameLabel: UILabel!
    @IBOutlet weak var person2JobLabel: UILabel!
    @IBOutlet weak var person2BirthLabel: UILabel!
    

    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    // どっちのカードが選択されているか
    var selectedCardCount: Int = 0
    // 次に表示されてる人のリストの番目
    var nextUserNum:Int = 2
    // 現在表示されている人のリストの番号
    var nowUserNum:Int = 0
    // ユーザーリスト
    let userList: [userData] = [
        userData(name: "津田梅子", image: #imageLiteral(resourceName: "津田梅子"), job: "教師", birth: "千葉", backColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        userData(name: "ジョージ・ワシントン", image: #imageLiteral(resourceName: "ジョージワシントン"), job: "大統領", birth: "アメリカ", backColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
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
        // personListにperson1から5を追加
        personList.append(person1)
        personList.append(person2)
    }

    // view表示前に呼ばれる（遷移すると戻ってくる度によばれる）
    override func viewWillAppear(_ animated: Bool) {
        // カウント初期化
        selectedCardCount = 0
        nextUserNum = 2
        nowUserNum = 0
        // リスト初期化
        likedName = []
    }

    // セグエによる遷移前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedListTableViewController

            // LikedListTableViewControllerのlikedName(左)にViewCountrollewのLikedName(右)を代入
            vc.likedName = likedName
        }
    }

    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
    override func viewDidDisappear(_ animated: Bool) {
        // ビューを整理
        self.view.sendSubviewToBack(person2)
        // alpha地をもとに戻す
        person1.alpha = 1
        person2.alpha = 1
        // ビューの初期化
        // 1枚目
        let user1 = userList[nowUserNum]
        person1.backgroundColor = user1.backColor
        person1Img.image = user1.image
        person1NameLabel.text = user1.name
        person1JobLabel.text = user1.job
        person1BirthLabel.text = user1.birth
        // 2枚目
        let user2 = userList[nowUserNum + 1]
        person2.backgroundColor = user2.backColor
        person2Img.image = user2.image
        person2NameLabel.text = user2.name
        person2JobLabel.text = user2.job
        person2BirthLabel.text = user2.birth
    }

    // カードを次のにする処理
    func nextPersonList() {
        // 背面にカードを持ってくる
        self.view.sendSubviewToBack(personList[selectedCardCount])
        // 中心に持ってくいる
        personList[selectedCardCount].center = centerOfCard
        personList[selectedCardCount].transform = .identity
        // すべて終わったときに画面を真っ白にする
        if nextUserNum < userList.count {
            selectCard()
        }else {
            person2.alpha = 0
        }
        // 次のカードへ行く
        nowUserNum += 1
        nextUserNum += 1
        if nowUserNum >= userList.count {
            person1.alpha = 0
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
        selectedCardCount = nowUserNum % 2
    }

    // 表示するユーザーカードを決める
    func selectCard() {
        // 表示するカードの名前の保存先
        let user = userList[nextUserNum]
        if selectedCardCount == 0 {
            person1.backgroundColor = user.backColor
            person1NameLabel.text = user.name
            person1JobLabel.text = user.job
            person1BirthLabel.text = user.birth
            person1Img.image = user.image
        }else{
            person2.backgroundColor = user.backColor
            person2NameLabel.text = user.name
            person2JobLabel.text = user.job
            person2BirthLabel.text = user.birth
            person2Img.image = user.image
        }
    }
    // カードを飛ばす処理
    func skipCard(distance: CGFloat) {
        personList[selectedCardCount].center = CGPoint(x: personList[selectedCardCount].center.x - distance, y: personList[selectedCardCount].center.y)
        // ベースカードのリセット
        resetCard()
    }
    
    // ベースカードを元に戻す
    func resetCard() {
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
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
                    self.personList[self.selectedCardCount].center = CGPoint(x: self.personList[self.selectedCardCount].center.x - 500, y :self.personList[self.selectedCardCount].center.y)

                })
                // ベースカードの角度と位置を戻す
                resetCard()
                // likeImageを隠す
                likeImage.isHidden = true
                // 次のカードへ
                selectedCardCount += 1

                if selectedCardCount >= personList.count {
                    // 遷移処理
                    performSegue(withIdentifier: "ToLikedList", sender: self)
                }

            } else if card.center.x > self.view.frame.width - 50 {
                // 右に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.5, animations: {
                    // 右へ飛ばす場合
                    // X座標を右に500とばす(+500)
                self.personList[self.selectedCardCount].center = CGPoint(x: self.personList[self.selectedCardCount].center.x + 500, y :self.personList[self.selectedCardCount].center.y)

                })
                // ベースカードの角度と位置を戻す
                resetCard()
                // likeImageを隠す
                likeImage.isHidden = true
                // いいねリストに追加
                likedName.append(userList[selectedCardCount])
                // 次のカードへ
                selectedCardCount += 1
                
                if selectedCardCount >= personList.count {
                    // 遷移処理
                    performSegue(withIdentifier: "ToLikedList", sender: self)
                }

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
    @IBAction func dislikeButtonTapped(_ sender: Any) {

        UIView.animate(withDuration: 0.5, animations: {
            // ベースカードをリセット
            self.resetCard()
            // ユーザーカードを左にとばす
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y:self.personList[self.selectedCardCount].center.y)
        })

        selectedCardCount += 1
        // 画面遷移
        if selectedCardCount >= personList.count {
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
    }

    // いいねボタン
    @IBAction func likeButtonTaped(_ sender: Any) {

        UIView.animate(withDuration: 0.5, animations: {
            self.resetCard()
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y:self.personList[self.selectedCardCount].center.y)
        })
        // いいねリストに追加
        likedName.append(userList[selectedCardCount])
        selectedCardCount += 1
        // 画面遷移
        if selectedCardCount >= personList.count {
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
    }
}

