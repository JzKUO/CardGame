//
//  Deck.swift
//  CardGameSwift
//
//  Created by 郭家政 on 2017/3/31.
//  Copyright © 2017年 郭家政. All rights reserved.
//

import Foundation

class Deck: NSObject {
	private let _cardValueSets = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	private let _cardSuitSets = ["♥", "♦", "♠", "♣"]

	private var _cards: Array<Card> = []

	//	將所有卡牌組合上花色
	private func CardParing() -> Void {
		for value in self._cardValueSets {
			for suit in self._cardSuitSets {

				let card = Card()

				if suit == "♥" || suit == "♦" {
					card.InitCard(title: value + suit, color: "red")
				} else {
					card.InitCard(title: value + suit, color: "black")
				}

				self._cards.append(card)
			}
		}
	}

	//	初始卡牌組
	public func InitDeck() -> Void {
		self.CardParing()
	}

	//	取得一組牌裡所有卡牌
	public func GetCards() -> Array<Card> {
		return self._cards
	}

	public func RemoveCard(index: Int) -> Void {
		self._cards.remove(at: index)
	}

	public func ResetDeck() -> Void {
		self._cards.removeAll()
		self.InitDeck()
	}
}
