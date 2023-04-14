//
//  MainViewModel.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 13.04.2023.
//

import Foundation

enum CardButtonType: String {
    case eye
    case trash
    case details
}

enum FontSize: CGFloat {
    case size1 = 22
    case size2 = 18
    case size3 = 14
}

enum DistanceValue: CGFloat {
    case arrow1 = 16
    case arrow2 = 50
    case arrow3 = 7
}

@MainActor
final class MainViewModel: NSObject, ObservableObject {
    
    @Published var alertIsPresented = false
    @Published var alertTitle = ""
    @Published var message = ""
    
    @Published var progressViewIsPresented = false
    @Published var dataIsDownloading = false
    @Published var degrees = 0.0
    
    @Published var cards: [CardCellModel] = []
    
    func downloadCards() {
        progressViewIsPresented = true
        dataIsDownloading = true
        print("////////////////////////////////////////////////////")
        
        NetworkManager.shared.getAllCards(currentCardsCount: cards.count) { [weak self] result in
            switch result {
            case .success(let cards):
                DispatchQueue.main.async { [weak self] in
                    if cards.isEmpty {
                        self?.progressViewIsPresented = false
                        print("⭐️ Подгрузка карт завершена, сервер прислал пустой массив")
                    } else {
                        cards.forEach { self?.cards.append(CardCellModel(card: $0)) }
                        print("✅ Партия карт подгружена (\(cards.count)): ", cards)
                    }
                    self?.dataIsDownloading = false
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    switch error {
                    case .error400(let message): self?.showAlertServer(title: message)
                    case .error401: self?.showAlertServer(title: "Ошибка авторизации")
                    case .error500: self?.showAlertServer(title: "Всё упало")
                    default: self?.showAlertServer(title: "Что-то пошло не так, проверьте наличие интернета")
                    }
                    
                    self?.dataIsDownloading = false
                    
                    // Лучше убрать данный способ, использовать таймер
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                        self?.downloadCards()
                    }
                }
            }
        }
    }
    
    func showAlertButton(cardIndex: Int, buttonType: CardButtonType) {
        print(cardIndex)
        alertTitle = "Нажата кнопка " + "\(buttonType)".capitalized
        message = "ID компании: " + cards[cardIndex].card.company.companyId
        alertIsPresented = true
    }
    
    private func showAlertServer(title: String) {
        self.alertTitle = title
        self.message = ""
        alertIsPresented = true
    }
}
