//
//  extensions.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/11/20.
//

import SwiftUI

extension View {
    func mainButtonStyle() -> some View {
        buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
    
    func roundedRectBackgrond(radius: CGFloat = 8,fill: some ShapeStyle = Color.bg ) -> some View {
        background(RoundedRectangle(cornerRadius: radius)
            .foregroundStyle(fill))}
}
extension Animation {
    static let mySpring = Animation.spring(dampingFraction: 0.55)
    static let myEase = Animation.easeInOut
}
extension Color {
    static let bg = Color(.systemBackground)
    static let bg2 = Color(.secondarySystemBackground)
}
extension AnyTransition {
     static let delayAnyOpacity = AnyTransition.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
}
