//
//  CardsAppApp.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 12.04.2023.
//

import SwiftUI

@main
struct CardsAppApp: App {
    @StateObject private var mainVM = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainVM) 
        }
    }
}
