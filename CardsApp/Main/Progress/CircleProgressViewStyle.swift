//
//  CircleProgressViewStyle.swift
//  CardsApp
//
//  Created by Анатолий Миронов on 13.04.2023.
//

import SwiftUI

struct CircleProgressViewStyle: ProgressViewStyle {
    @Binding var degrees: Double
    let progress = 0.4
    let lineWidth: CGFloat = 5
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(Color.clear)
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundColor(Color(hex: "1a1a1a"))
                .rotationEffect(.degrees(degrees))
                .onAppear {
                    withAnimation(.linear(duration: 0.95).repeatForever(autoreverses: false)) {
                        degrees = 360.0
                    }
                }
        }
    }
}

struct CircleProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .progressViewStyle(CircleProgressViewStyle(degrees: .constant(0.0)))
            .frame(width: 40, height: 40)
    }
}
