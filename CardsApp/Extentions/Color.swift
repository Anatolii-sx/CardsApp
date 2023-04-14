//
//  Color.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 14.04.2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let validateCode = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: validateCode)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }
}
