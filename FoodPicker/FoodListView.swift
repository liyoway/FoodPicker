//
//  FoodListView.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/11/30.
//

import SwiftUI

struct FoodListView: View {
    @Environment(\.editMode) var editMode
    @State private var food = Food.examples
    @State private var selectedFood = Set<Food.ID>()
    
    var isEditing: Bool { editMode?.wrappedValue == .active }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar
            
            List($food, editActions: .all, selection: $selectedFood) { $food in
                Text(food.name)
           }
            .listStyle(.plain)
            .padding(.horizontal)
            
        }
        .background(.groupBG)
        .safeAreaInset(edge: .bottom, content: buildFloatButton)
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
    
    var removeButton : some View {
        Button {
            withAnimation {
                food = food.filter { !selectedFood.contains($0.id) }
            }
        } label: {
            Text("刪除全部")
                .font(.title2.bold())
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                        .scaleEffect(isEditing ? 0 : 1)
                        .opacity(isEditing ? 0 : 1)
                        .animation(.easeInOut, value: isEditing)
                }
            }
        }
}

#Preview {
    FoodListView()
}
