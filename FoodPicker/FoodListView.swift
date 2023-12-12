//
//  FoodListView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/11/30.
//

import SwiftUI

struct FoodListView: View {
    @State private var food = Food.examples
    @State private var seletedFood = Set<Food.ID>()
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            
            List($food, editActions: .all, selection: $seletedFood) { $food in
                Text(food.name)
           }
            .listStyle(.plain)
            .padding(.horizontal)
            
        }
        .background(.groupBG)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            addButton
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
        } .padding()
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
}

#Preview {
    FoodListView()
}
