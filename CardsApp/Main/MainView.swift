//
//  ContentView.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 12.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: DistanceValue.arrow1.rawValue) {
                        ForEach(0..<mainVM.cards.count, id: \.self) { index in
                            CardCellView(
                                cell: mainVM.cards[index],
                                eyeButtonTapped: {
                                    mainVM.showAlertButton(cardIndex: index, buttonType: CardButtonType.eye)
                                },
                                trashButtonTapped: {
                                    mainVM.showAlertButton(cardIndex: index, buttonType: CardButtonType.trash)
                                },
                                detailsButtonTapped: {
                                    mainVM.showAlertButton(cardIndex: index, buttonType: CardButtonType.details)
                                })
                            .cornerRadius(30)
                        }
                    }
                    .padding(.top, DistanceValue.arrow1.rawValue * 3.6)
                    .padding(.bottom, DistanceValue.arrow1.rawValue)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onChange(of: proxy.frame(in: .global).minY) { value in
                                    let scrollOffset = value - 44
                                    let contentHeight = CGFloat(mainVM.cards.count) * 250 - UIScreen.main.bounds.height * 0.74
                                    
                                    if abs(scrollOffset) >= contentHeight && mainVM.progressViewIsPresented  {
                                        if !mainVM.dataIsDownloading {
                                            mainVM.downloadCards()
                                        }
                                    }
                                    
                                    print("Content height: ", contentHeight)
                                    print("Scroll offset: ", Int(scrollOffset))
                                }
                        }
                    )
                    
                    if mainVM.progressViewIsPresented {
                        VStack(spacing: 8) {
                            ProgressView()
                                .progressViewStyle(CircleProgressViewStyle(degrees: $mainVM.degrees))
                                .frame(width: 40, height: 40)
                            Text("Подгрузка компаний")
                                .foregroundColor(Color(hex: "1a1a1a"))
                        }
                        .padding(.top, DistanceValue.arrow1.rawValue)
                    }
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: DistanceValue.arrow1.rawValue,
                    bottom: 0,
                    trailing: DistanceValue.arrow1.rawValue
                )
            )
            
            VStack {
                EmptyView()
                    .background(Color(hex: "ffffff"))
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                Text("Управление картами")
                    .font(.system(size: FontSize.size1.rawValue))
                    .frame(maxWidth: .infinity)
//                    .padding(.top, PaddingValue.arrow1.rawValue)
                    .padding(.bottom, DistanceValue.arrow1.rawValue)
                    .background(Color(hex: "ffffff"))
                    .foregroundColor(Color(hex: "2688eb"))
                Spacer()
            }
            
            
        }
        .background(Color(hex: "efefef"))
        .onAppear {
            mainVM.downloadCards()
        }
        .alert(isPresented: $mainVM.alertIsPresented) {
            Alert(
                title: Text(mainVM.alertTitle),
                message: Text(mainVM.message)
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(MainViewModel())
    }
}
