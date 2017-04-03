//
//  PlayingCardDeck.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/4/3.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import Foundation

class PlayingCardDeck: Deck {
	private var _playingCardDeck: Array<Card> = []

	// 取得所有抽出的卡牌
	public func GetPlayingCards() -> Array<Card> {
		return self._playingCardDeck
	}

	// 移除卡牌
	public func RemovePlayingCard(index: Int) {
		self._playingCardDeck.remove(at: index)
	}

	// 加入卡牌
	public func AddCard(card: Card) -> Void {
		self._playingCardDeck.append(card)
	}

	// 重置卡牌（移除所有被抽出的牌）
	func ResetPlayingDeck() -> Void {
		self._playingCardDeck.removeAll()
	}
}
