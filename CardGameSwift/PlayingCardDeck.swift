//
//  PlayingCardDeck.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/4/3.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import Foundation

class PlayingCardDeck: Deck {
	private var _cards: Array<Card> = []

	// 取得所有抽出的卡牌
	public override func GetCards() -> Array<Card> {
		return self._cards
	}

	// 移除卡牌
	public override func RemoveCard(index: Int) {
		self._cards.remove(at: index)
	}

	// 加入卡牌
	public func AddCard(card: Card) -> Void {
		self._cards.append(card)
	}

	// 重置卡牌（移除所有被抽出的牌）
	public override func Reset() -> Void {
		self._cards.removeAll()
	}
}
