//
//  ContentView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/9/20.
//

import SwiftUI

struct ContentView: View {

    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]
    
    @State private var selectedFood: String?
    
    var body: some View {
        VStack(spacing: 30.0) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("今天吃什麼？")
                .font(.title)
                .bold()
            
            if selectedFood != .none {
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.orange)
            }
            
            Button(role: .none) {
                selectedFood = food.randomElement()
            } label: {
                Text(selectedFood == .none ? "告訴我！" : "換一個")
                    .multilineTextAlignment(.center)
                    .frame(width: 200.0)
            }
            .padding(.bottom, -15)
            
            
            Button(role: .none) {
                selectedFood = .none
            } label: {
                Text("重置")
                    .multilineTextAlignment(.center)
                    .frame(width: 200.0)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.largeTitle)
        .buttonStyle(.borderedProminent)
        .animation(.easeInOut, value: selectedFood)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
}

#Preview {
    ContentView()
}
