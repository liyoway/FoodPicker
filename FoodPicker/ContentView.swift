//
//  ContentView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/9/20.
//

import SwiftUI

struct ContentView: View {
    let food = Food.examples
    @State private var selectedFood: Food?

    var body: some View {
        VStack(spacing: 30.0) {
            Group {
                if selectedFood != .none {
                    Text(selectedFood!.image)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                } else {
                    Image("dinner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(height: 250)
            .border(.red)

            Text("今天吃什麼？")
                .bold()

            if selectedFood != .none {
                let calorie = Int(selectedFood!.calorie)
                let protein = Int(selectedFood!.protein)
                let fat = Int(selectedFood!.fat)
                let carb = Int(selectedFood!.carb)
                
                HStack {
                    Text("\(selectedFood!.name)")
                        .foregroundStyle(.orange)
                        .bold()
                        .font(.largeTitle)
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .id(selectedFood!.name)
                .transition(.asymmetric(
                    insertion: .opacity
                        .animation(.easeInOut(duration: 0.5).delay(0.2)),
                    removal: .opacity
                        .animation(.easeInOut(duration: 0.4))))
                Text("熱量 \(calorie) 大卡")
                    .font(.title2)
                HStack {
                    VStack(spacing: 12) {
                        Text("蛋白質")
                        Text("\(protein)g")
                    }
                    Divider().padding(.horizontal)
                    VStack(spacing: 12) {
                        Text("脂肪")
                        Text("\(fat)g")
                    }
                    Divider().padding(.horizontal)

                    VStack(spacing: 12) {
                        Text("碳水")
                        Text("\(carb)g")
                    }
                }
                .font(.title2)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
            }

            
            Spacer()

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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.largeTitle)
        .buttonStyle(.borderedProminent)
        .animation(.easeInOut, value: selectedFood)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

// 預覽部分
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedFood: .examples.first!)
    }
}
