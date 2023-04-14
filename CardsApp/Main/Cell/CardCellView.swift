//
//  CardCellView.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 12.04.2023.
//

import SwiftUI

struct CardCellView: View {
    var cell: CardCellModel
    
    let eyeButtonTapped: () -> Void
    let trashButtonTapped: () -> Void
    let detailsButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(cell.card.mobileAppDashboard.companyName)
                    .foregroundColor(Color(hex: cell.card.mobileAppDashboard.highlightTextColor))
                    .font(.system(size: FontSize.size1.rawValue))
                Spacer()
                
                if let logo = URL(string: cell.card.mobileAppDashboard.logo) {
                    AsyncImage(url: logo) { status in
                        switch status {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .background(Color(.systemBlue))
                                .clipShape(Circle())
                        default:
                            ProgressView()
                                .frame(width: 45, height: 45)
                        }
                    }
                } else {
                    ProgressView()
                        .frame(width: 45, height: 45)
                }
            }
            
            Divider()
                .padding(.vertical, DistanceValue.arrow3.rawValue)
            
            HStack {
                HStack(spacing: 0) {
                    Text(String(cell.card.customerMarkParameters.mark))
                        .foregroundColor(Color(hex: cell.card.mobileAppDashboard.highlightTextColor))
                        .font(.system(size: FontSize.size1.rawValue, weight: .medium))
                    Text("баллов")
                        .foregroundColor(Color(hex: cell.card.mobileAppDashboard.textColor))
                        .font(.system(size: FontSize.size2.rawValue))
                        .padding(.leading, DistanceValue.arrow3.rawValue)
                }
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: DistanceValue.arrow1.rawValue,
                    leading: 0,
                    bottom: DistanceValue.arrow1.rawValue,
                    trailing: 0
                )
            )
            
            HStack(spacing: DistanceValue.arrow2.rawValue) {
                VStack(alignment: .leading, spacing: DistanceValue.arrow3.rawValue - 5) {
                    Text("Кешбэк")
                        .foregroundColor(Color(hex: cell.card.mobileAppDashboard.textColor))
                        .font(.system(size: FontSize.size3.rawValue))
                    Text(String(cell.card.customerMarkParameters.loyaltyLevel.number) + " %")
                        .font(.system(size: FontSize.size2.rawValue))
                }
                
                VStack(alignment: .leading, spacing: DistanceValue.arrow3.rawValue - 5) {
                    Text("Уровень")
                        .foregroundColor(Color(hex: cell.card.mobileAppDashboard.textColor))
                        .font(.system(size: FontSize.size3.rawValue))
                    Text(cell.card.customerMarkParameters.loyaltyLevel.name)
                        .font(.system(size: FontSize.size2.rawValue))
                }
                Spacer()
            }
            
            Divider()
                .padding(.vertical, DistanceValue.arrow3.rawValue)
            
            HStack {
                HStack(spacing: DistanceValue.arrow2.rawValue) {
                    Button(action: eyeButtonTapped) {
                        Image("eye_white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .colorMultiply(Color(hex: cell.card.mobileAppDashboard.mainColor))
                    }
                    
                    Button(action: trashButtonTapped) {
                        Image("trash_white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .colorMultiply(Color(hex: cell.card.mobileAppDashboard.accentColor))
                    }
                }
                .padding(.leading, DistanceValue.arrow1.rawValue)
                
                Spacer()
                
                Button(action: detailsButtonTapped) {
                    Text("Подробнее")
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .background(Color(hex: cell.card.mobileAppDashboard.backgroundColor))
                        .foregroundColor(Color(hex: cell.card.mobileAppDashboard.mainColor))
                        .font(.system(size: FontSize.size2.rawValue))
                        .cornerRadius(10)
                }
                
            }
        }
        .padding(DistanceValue.arrow1.rawValue)
        .background(Color(hex: cell.card.mobileAppDashboard.cardBackgroundColor))
    }
}

struct CardCellView_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(
            cell: CardCellModel(
                card: Card(
                    company: Company(companyId: "1C"),
                    customerMarkParameters:
                        CustomerMarkParameters(
                            loyaltyLevel:
                                LoyaltyLevel(
                                    cashToMark: 30,
                                    markToCash: 35,
                                    name: "Золотой",
                                    number: 9,
                                    requiredSum: 13587
                                ),
                            mark: 2500),
                    mobileAppDashboard:
                        MobileAppDashboard(
                            accentColor: "#73DCD7",
                            backgroundColor: "#88CFBB",
                            cardBackgroundColor: "#FDDFFD",
                            companyName: "Венская кофейня",
                            highlightTextColor: "#DE8331",
                            logo: "http://bonusmoney.info/image/mail/bm.png",
                            mainColor: "#9FBAS2",
                            textColor: "#196D29"
                        )
                )
            ),
            eyeButtonTapped: {},
            trashButtonTapped: {},
            detailsButtonTapped: {}
        )
    }
}
