//
//  CardMatchingGame.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/4/3.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import Foundation
import UIKit

class CardMatchingGame: NSObject {
	private let _deck = Deck()
	private let _copyDeck = Deck()
	private let _playingCardDeck = PlayingCardDeck()
	private let _copyPlayingCardDeck = PlayingCardDeck()
	private var _matchCount = 0	// 配對成功的次數
	private var _isPeeked: Bool = false	// 判斷是否為全部被翻正面（偷看）

	// 用來暫存翻開的兩張牌（用來比對）
	private let _matchCardDeck = PlayingCardDeck()

	// 定義遊戲初始事件
	public func InitGame() -> Void {
		self._deck.InitDeck()
		self._copyDeck.InitDeck()
		self.DrawCard()
	}

	private func DrawCard() -> Void {
		/*
		* MARK: 複製 array 不能直接用 asign（=）的！！！
		* 一樣要實體化
		* 然後一個一個加進去
		*
		* let copyDeck = self._playingCardDeck 這樣是錯的！！！
		*
		* 不過要注意，用 append 的方式會像是『指標』一樣
		* 所以新的 array 改變值時，其實是改到舊的 array
		*/

		// 從 Deck 中抽出一場遊戲一半的牌，並複製一份到 PlayingCardDeck2
		for _ in 0...7 {
			// 亂數找卡牌
			let index = Int(arc4random()) % self._deck.GetCards().count

			// 將牌加入 PlayingCardDeck
			self._playingCardDeck.AddCard(card: self._deck.GetCards()[index])
			self._copyPlayingCardDeck.AddCard(card: self._copyDeck.GetCards()[index])

			// 將牌從 Deck 中移除
			self._deck.RemoveCard(index: index)
			self._copyDeck.RemoveCard(index: index)
		}

		// 從 PlayingCardDeck 移到 PlayingCardDeck2
		var counter = self._playingCardDeck.GetCards().count - 1
		for i in (0 ... counter).reversed() {

			// 將牌加入 PlayingCardDeck
			self._copyPlayingCardDeck.AddCard(card: self._playingCardDeck.GetCards()[i])

			// 將牌從 Deck 中移除
			self._playingCardDeck.RemoveCard(index: i)
		}

		// 從 PlayingCardDeck2 中亂數加到 PlayingCardDeck 裡面
		counter = self._copyPlayingCardDeck.GetCards().count - 1
		for _ in (0 ... counter).reversed() {
			// 亂數找卡牌
			let index = Int(arc4random()) % self._copyPlayingCardDeck.GetCards().count

			// 將牌加入 PlayingCardDeck
			self._playingCardDeck.AddCard(card: self._copyPlayingCardDeck.GetCards()[index])

			// 將牌從 PlayingCardDeck2 中移除
			self._copyPlayingCardDeck.RemoveCard(index: index)
		}

		// 加入紀錄事件
		for item in self._playingCardDeck.GetCards() {
			item.addTarget(self, action: #selector(self.StackCard), for: .touchUpInside)
		}
	}

	// FIXME: 重複按自己會被視為配對成功（BUG）

	// 暫存（兩張）牌
	internal func StackCard(card: Card) -> Void {
//		print(card.GetTitle())
		if self._matchCardDeck.GetCards().count == 0 {
			// 如果沒有牌，就加入
			self._matchCardDeck.AddCard(card: card)
		} else {
			// 如果有一張牌，加入第二張，並且比對
			self._matchCardDeck.AddCard(card: card)
			self.CompareCard(card1: self._matchCardDeck.GetCards()[0], card2: self._matchCardDeck.GetCards()[1])

			// 重置
			self._matchCardDeck.Reset()
		}
	}

	// 比較兩張牌是否一樣
	private func CompareCard(card1: Card, card2: Card) -> Void {
		if card1.GetTitle() == card2.GetTitle() {
			card1.isEnabled = false
			card2.isEnabled = false
			self._matchCount += 1
		} else {
			// 設定一秒後翻回反面
			Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
				card1.FlipToBack()
				card2.FlipToBack()
			}
		}
	}

	// 取得已抽出的卡牌
	public func GetPlayingCardDeck() -> PlayingCardDeck {
		return self._playingCardDeck
	}

	// 是否偷看牌
	public func IsPeeked() -> Bool {
		return self._isPeeked
	}

	// 設定為：偷看中/沒被偷看
	public func SetPeeked(value: Bool) -> Void {
		self._isPeeked = value
	}

	// 重置遊戲
	public func ResetGame() -> Void {
		self._deck.Reset()
		self._copyDeck.Reset()
		self._playingCardDeck.Reset()
	}

	// 遊戲是否結束
	public func IsEnd() -> Bool {
		if self._matchCount == 8 {
			self._matchCount = 0
			return true
		}
		return false
	}
}
