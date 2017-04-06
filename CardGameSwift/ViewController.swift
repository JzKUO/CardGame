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
	@IBOutlet weak var startButton: UIButton!

	// 計分器
	@IBOutlet weak var _scoreLabel: UILabel!

	// 計時器
	@IBOutlet weak var secondTime: UILabel!
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
		self._second         = 0
		self.secondTime.text = "0"
		self._timer.invalidate()
		// 初始計分器
		self._scoreLabel.text = "0"

		// 將牌部署到畫面上
		var index = 0
		for i in 0...3 {
			for j in 0...3 {
				// 產生卡牌
				self._game.GetPlayingCardDeck().GetCards()[index]
					.GenerateCard(x: j, y: i, view: self)

				// 將卡牌翻至背面
				self._game.GetPlayingCardDeck().GetCards()[index]
					.FlipToBack()

				index += 1
			}
		}

		for card in self._game.GetPlayingCardDeck().GetCards() {
			// 加入判斷遊戲結束的觸發事件
			card.addTarget(self,
			               action: #selector(self.EndGame),
			               for: .touchUpInside)

			// 加入更新分數觸發事件
			card.addTarget(self,
			               action: #selector(self.UptadeScore),
			               for: .touchUpInside)
		}
	}

	func EndGame() -> Void {
		if self._game.IsEnd() {
			self._timer.invalidate()
		}
	}

	func UptadeScore() -> Void {
		self._scoreLabel.text = String(self._game.GetScore())
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
		if !self._game.IsPeeked() {
			for i in 0...15 {
				if self._game.GetPlayingCardDeck().GetCards()[i].isEnabled {
					self._game.GetPlayingCardDeck().GetCards()[i].FlipToFront()
				}
			}
			self._game.SetPeeked(value: true)
		} else {
			for i in 0...15 {
				if self._game.GetPlayingCardDeck().GetCards()[i].isEnabled {
					self._game.GetPlayingCardDeck().GetCards()[i].FlipToBack()
				}
			}
			self._game.SetPeeked(value: false)
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

