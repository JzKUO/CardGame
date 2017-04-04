//
//  ViewController.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/3/30.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let _game = CardMatchingGame()
	@IBOutlet weak var secondTime: UILabel!
	@IBOutlet weak var startButton: UIButton!
	var _timer: Timer = Timer()
	var _second = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		//	載入時呼叫初始化
		InitAll()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	//	定義初始化事件
	func InitAll() -> Void {
		self._game.InitGame()

		// 啟用開始按鈕
		self.startButton.isEnabled = true
		// 初始計數器
		self._second = 0
		self.secondTime.text = "0"
		self._timer.invalidate()

		// 將牌部署到畫面上
		var index = 0
		for i in 0...3 {
			for j in 0...3 {
				// 產生卡牌
				self._game.GetPlayingCardDeck().GetCards()[index].GenerateCard(x: j, y: i, view: self)

				// 將卡牌翻至背面
				self._game.GetPlayingCardDeck().GetCards()[index].FlipCard()

				index += 1
			}
		}

		// 加入判斷遊戲結束的觸發事件
		for card in self._game.GetPlayingCardDeck().GetCards() {
			card.addTarget(self, action: #selector(self.EndGame), for: .touchUpInside)
		}
	}

	func EndGame() -> Void {
		if self._game.IsEnd() {
			self._timer.invalidate()
		}
	}

	// 開始遊戲按鈕
	@IBAction func StartButton(_ sender: UIButton) {
		// 關閉開始按鈕
		sender.isEnabled = false

		// 使所有牌可點擊
		for card in self._game.GetPlayingCardDeck().GetCards() {
			card.isEnabled = true
		}

		// 計時
		self._timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self._second += 1
			self.secondTime.text = String(self._second)
		}
	}

	// 一次將所有牌翻面
	@IBAction func FlipAllCard(_ sender: UIButton) {
		for i in 0...15 {
			if self._game.GetPlayingCardDeck().GetCards()[i].isEnabled {
				self._game.GetPlayingCardDeck().GetCards()[i].FlipCard()
			}
		}
	}

	// 重置遊戲
	@IBAction func ResetGame(_ sender: UIButton) {
		// 從畫面中移除
		for card in self._game.GetPlayingCardDeck().GetCards() {
			card.removeFromSuperview()
		}
		
		self._game.ResetGame()
		self.InitAll()
	}
}

