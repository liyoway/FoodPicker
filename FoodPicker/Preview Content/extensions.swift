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
    
    func roundedRectBackgrond(radius: CGFloat = 8, fill: some ShapeStyle = .bg ) -> some View {
        background(RoundedRectangle(cornerRadius: radius)
            .fill(fill))
     }
}
extension Animation {
    static let mySpring = Animation.spring(dampingFraction: 0.55)
    static let myEase = Animation.easeInOut
}
extension ShapeStyle where Self == Color {
    static var bg: Color {
        Color(.systemBackground)
    }
    static var bg2: Color {
        Color(.secondarySystemBackground)
    }
    static var groupBG: Color { Color(.systemGroupedBackground) }
}
extension AnyTransition {
     static let delayAnyOpacity = AnyTransition.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
}

extension AnyLayout {
    static func useVStack(if condition: Bool, spacing: CGFloat, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        
        return layout(content)
    }
}
