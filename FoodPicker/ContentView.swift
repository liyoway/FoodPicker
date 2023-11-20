//
//  ContentView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/9/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    let food = Food.examples
    var body: some View {
        ScrollView {
            VStack(spacing: 30.0) {
                foodImage
                
                Text("今天吃什麼？").bold()
                
                selectFoodInfoView
                
                Spacer().layoutPriority(0)
                
                selectedFoodButton
                
                cancelButton
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.largeTitle)
            .animation(. mySpring, value: shouldShowInfo)
            .animation(.myEase, value: selectedFood)
            .mainButtonStyle()
        }
        .background(Color.bg2)
    }
}
    
private extension ContentView {
    //MARK: subViews
    @ViewBuilder var selectFoodInfoView: some View {
        if selectedFood != nil {
            foodNameView
            Text("熱量\(selectedFood!.$calorie)").font(.title2)
        }
        foodDetailView
        
        
    }
    var foodImage: some View {
        Group {
            if selectedFood != nil {
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
    }
    var foodNameView: some View {
        HStack {
            Text("\(selectedFood!.name)")
                .foregroundStyle(.orange)
                .bold()
                .font(.largeTitle)
                .id(selectedFood!.name)
                .transition(.delayAnyOpacity)
            Button {
                shouldShowInfo.toggle()
            } label : {
                Image(systemName: "info.circle.fill").foregroundStyle(.secondary)
            }.buttonStyle(.plain)
        }
        
    }
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                      
                    GridRow {
                        Text("蛋白質")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)
                    
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    
                    GridRow {
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .roundedRectBackgrond()
                .transition(.moveUpWithOpacity)
            }
        }
        .clipped()
        .frame(maxWidth: .infinity)
        
    }
    
    var selectedFoodButton: some View {
        Button(role: .none) {
            selectedFood = food.randomElement()
        } label: {
            Text(selectedFood == nil ? "告訴我！" : "換一個")
                .multilineTextAlignment(.center)
                .frame(width: 200.0)
        }
        .padding(.bottom, -15)
    }
    var cancelButton: some View {
        Button(role: .none) {
            selectedFood = nil
            shouldShowInfo = false
        } label: {
            Text("重置")
                .multilineTextAlignment(.center)
                .frame(width: 200.0)
        }
        .buttonStyle(.bordered)
    }
}

extension ContentView {
    // 自定義初始化方法，方便預覽時指定食物
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

// 提供ContentView的預覽
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedFood: .examples.first!)
    }
}

