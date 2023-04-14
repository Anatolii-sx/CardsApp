//
//  Card.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 13.04.2023.
//

import Foundation

struct Card: Codable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

struct Company: Codable {
    let companyId: String
}

struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

struct LoyaltyLevel: Codable {
    let cashToMark: Int
    let markToCash: Int
    let name: String
    let number: Int
    let requiredSum: Int
}

struct MobileAppDashboard: Codable {
    let accentColor: String
    let backgroundColor: String
    let cardBackgroundColor: String
    let companyName: String
    let highlightTextColor: String
    let logo: String
    let mainColor: String
    let textColor: String
}
