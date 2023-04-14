//
//  CardCellModel.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 12.04.2023.
//

import Foundation

// Модель ячейки (строки/row) с картой
struct CardCellModel: Identifiable {
    var id = UUID()
    var card: Card
}
