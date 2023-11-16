//
//  ContentView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/9/20.
//

import SwiftUI

// ContentView結構定義了用戶界面的佈局和行為
struct ContentView: View {
    // 聲明一些狀態和屬性
    let food = Food.examples
    @State private var selectedFood: Food?
    @State private var showInfo: Bool = false
    
    // body定義了視圖的內容
    var body: some View {
        ScrollView {
            VStack(spacing: 30.0) {
                // 根據是否有選擇的食物來決定顯示的內容
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
                
                Text("今天吃什麼？")
                    .bold()
                
                // 如果選擇了食物，顯示詳細資訊
                if selectedFood != nil {
                    let calorie = Int(selectedFood!.calorie)
                    
                    HStack {
                        Text("\(selectedFood!.name)")
                            .foregroundStyle(.orange)
                            .bold()
                            .font(.largeTitle)
                            .id(selectedFood!.name)
                            .transition(.asymmetric(
                                insertion: .opacity
                                    .animation(.easeInOut(duration: 0.5).delay(0.2)),
                                removal: .opacity
                                    .animation(.easeInOut(duration: 0.4))))
                        Button {
                            showInfo.toggle()
                        } label : {
                            Image(systemName: "info.circle.fill")
                                .foregroundStyle(.secondary)
                        }.buttonStyle(.plain)
                    }

                    Text("熱量\(calorie) 大卡")
                        .font(.title2)
                }
                
                // 顯示營養資訊的區塊
                VStack {
                    if showInfo {
                        Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                            let calorie = Int(selectedFood!.calorie)
                            let protein = Int(selectedFood!.protein)
                            let fat = Int(selectedFood!.fat)
                            let carb = Int(selectedFood!.carb)

                            GridRow {
                                Text("蛋白質")
                                Text("脂肪")
                                Text("碳水")
                            }.frame(minWidth: 60)
                            
                            Divider()
                                .gridCellUnsizedAxes(.horizontal)
                                .padding(.horizontal, -10)
                            
                            GridRow {
                                Text("\(protein)g")
                                Text("\(fat)g")
                                Text("\(carb)g")
                            }
                        }
                        .font(.title3)
                        .padding(.horizontal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
                .clipped()
                .frame(maxWidth: .infinity)
                
                // 其他按鈕和布局
                Spacer().layoutPriority(0)
                
                Button(role: .none) {
                    selectedFood = food.randomElement()
                } label: {
                    Text(selectedFood == nil ? "告訴我！" : "換一個")
                        .multilineTextAlignment(.center)
                        .frame(width: 200.0)
                }
                .padding(.bottom, -15)
                
                Button(role: .none) {
                    selectedFood = nil
                    showInfo = false
                } label: {
                    Text("重置")
                        .multilineTextAlignment(.center)
                        .frame(width: 200.0)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.largeTitle)
            .buttonStyle(.borderedProminent)
            .animation(.spring(dampingFraction: 0.55), value: showInfo)
            .animation(.easeInOut, value: selectedFood)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .background(Color(.secondarySystemBackground))
    }
}

// 擴展ContentView以便於預覽
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

