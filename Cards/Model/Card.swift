//
//  Card.swift
//  Cards
//
//  Created by Женя  on 14.03.22.
//

import UIKit

// типы фигуры карт
enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
}


// цвета карт
enum CardColor: CaseIterable {
    case req
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}


// игральная карточка
typealias Card = (type: CardType, color: CardColor)


