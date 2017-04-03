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
		var counter = 0

		for i in 0...3 {
			for j in 0...3 {
				// 產生卡牌
				self._game.GetPlayingCardDeck().GetPlayingCards()[counter].GenerateCard(x: j, y: i, view: self)

				// 將卡牌翻至背面
				self._game.GetPlayingCardDeck().GetPlayingCards()[counter].FlipCard()

				counter += 1
			}
		}
	}

	// 一次將所有牌翻面
	@IBAction func FlipAllCard(_ sender: UIButton) {
		for i in 0...15 {
			self._game.GetPlayingCardDeck().GetPlayingCards()[i].FlipCard()
		}
	}

	// 重置遊戲
	@IBAction func ResetGame(_ sender: UIButton) {
		self._game.ResetGame()
		self.InitAll()
	}
}

