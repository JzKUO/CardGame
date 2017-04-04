//
//  CardMatchingGame.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/4/3.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import Foundation

class CardMatchingGame: NSObject {
	private let _deck = Deck()
	private let _deck2 = Deck()
	private let _playingCardDeck = PlayingCardDeck()
	private let _playingCardDeck2 = PlayingCardDeck()
	private var _maxCardNumber: Int = 52

	// 定義遊戲初始事件
	public func InitGame() -> Void {
		self._deck.InitDeck()
		self._deck2.InitDeck()

		/*
		* 複製 array 不能直接用 asign（=）的！！！
		* 一樣要實體化
		* 然後一個一個加進去
		*
		* let copyDeck = self._playingCardDeck 這樣是錯的！！！
		*
		* 不過要注意，用 append 的方式會像是『指標』一樣
		* 所以新的 array 改變值時，其實是改到舊的 array
		*/

		// 從 Deck 中抽出一半的牌，並複製一份到 PlayingCardDeck2
		for _ in 0...7 {
			// 亂數找卡牌
			let index = Int(arc4random()) % self._deck.GetCards().count

			// 將牌加入 PlayingCardDeck
			self._playingCardDeck.AddCard(card: self._deck.GetCards()[index])
			self._playingCardDeck2.AddCard(card: self._deck2.GetCards()[index])

			// 將牌從 Deck 中移除
			self._deck.RemoveCard(index: index)
			self._deck2.RemoveCard(index: index)
		}

		// 從 PlayingCardDeck2 中亂數加到 PlayingCardDeck 裡面
		for _ in 0...7 {
			// 亂數找卡牌
			let index = Int(arc4random()) % self._playingCardDeck2.GetPlayingCards().count

			// 將牌加入 PlayingCardDeck
			self._playingCardDeck.AddCard(card: self._playingCardDeck2.GetPlayingCards()[index])

			// 將牌從 PlayingCardDeck2 中移除
			self._playingCardDeck2.RemovePlayingCard(index: index)
		}
	}

	// 取得已抽出的卡牌
	public func GetPlayingCardDeck() -> PlayingCardDeck {
		return self._playingCardDeck
	}

	// 重置遊戲
	public func ResetGame() -> Void {
		self._deck.ResetDeck()
		self._deck2.ResetDeck()
		self._playingCardDeck.ResetPlayingDeck()
	}
}
