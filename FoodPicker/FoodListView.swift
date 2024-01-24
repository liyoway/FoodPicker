//
//  FoodListView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/11/30.
//

import SwiftUI

struct FoodListView: View {
    @Environment(\.editMode) var editMode
    @Environment(\.dynamicTypeSize) var textSize
    @State private var shouldShowSheet = false
    @State private var food = Food.examples
    @State private var selectedFood = Set<Food.ID>()
    @State private var foodDetailHeight: CGFloat = FoodDetailSheetHeightKey.defaultValue

    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar

            List($food, editActions: .all, selection: $selectedFood) { $food in
                HStack {
                    Text(food.name).padding(.vertical, 10)
                        .frame(width: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isEditing { return }
                            shouldShowSheet = true
                        }
                    Spacer()
                    if isEditing {
                        Image(systemName: "pencil")
                            .font(.title2.bold())
                            .foregroundColor(.accentColor)
                    }
                }
                
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .background(.groupBG)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
        .sheet(isPresented: $shouldShowSheet) {
            let food = food[4]
            let shouldUseVstack = textSize.isAccessibilitySize || food.image.count > 1

            AnyLayout.useVStack(if: shouldUseVstack, spacing: 30) {
                Text(food.image)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(shouldUseVstack ? 1 : 0.5)
                Grid(horizontalSpacing: 30, verticalSpacing: 12) {
                    buildNutrionView(title: "熱量", value: food.$calorie)
                    buildNutrionView(title: "蛋白質", value: food.$protein)
                    buildNutrionView(title: "脂肪", value: food.$fat)
                    buildNutrionView(title: "碳水", value: food.$carb)
                }
            }
            .padding()
            .padding(.vertical)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: FoodDetailSheetHeightKey.self, value: proxy.size.height)
                }
                .onPreferenceChange(FoodDetailSheetHeightKey.self) {
                    foodDetailHeight = $0
                }
                .presentationDetents([.height(foodDetailHeight)])
            }
        }
    }
}

private extension FoodListView {
    
    struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 300 // 提供預設值

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

private extension FoodListView {
    
    var titleBar : some View {
        HStack {
            Label("食物清單", systemImage: "fork.knife")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            EditButton()
                .buttonStyle(.bordered)
        }
        .padding()
    }
    
    var addButton : some View {
        Button { } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }
    
    var removeButton : some View {
        Button {
            withAnimation {
                food = food.filter { !selectedFood.contains($0.id) }
            }
        } label: {
            Text("刪除全部")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 8))
        .padding(.horizontal, 50)
    }
    
    func buildFloatButton() -> some View {
        ZStack {
            removeButton
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditing ? 1 : 0)
                .id(isEditing)
            
            HStack {
                Spacer()
                addButton
                    .scaleEffect(isEditing ? 0.0001 : 1)
                    .opacity(isEditing ? 0 : 1)
                    .animation(.easeInOut, value: isEditing)
            }
        }
    }
    
    func buildNutrionView(title: String, value: String) -> some View {
        GridRow {
            Text(title).gridCellAnchor(.leading)
            Text(value).gridCellAnchor(.trailing)
        }
    }
}

#Preview {
     FoodListView()
 }
