//
//  FoodForm.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/12/12.
//

import SwiftUI

extension FoodListView {
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
//        @FocusState private var filed: MyField?
        @State var food: Food
        var onSubmit: (Food) -> Void
        
        private var isNotValid: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        private var invalidMessage: String? {
            if food.name.isEmpty {
                return "請輸入名稱"
            } else if food.image.count > 2 {
                return "圖示字數過多"
            } else {
                return .none
            }
        }

        var body: some View {
            VStack {
                HStack {
                    Label("編輯食物資訊", systemImage: "pencil")
                        .font(.title.bold())
                        .foregroundColor(.accentColor)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle.bold())
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            dismiss()
                        }
                }
                .padding([.horizontal, .top])

                Form {
                    LabeledContent("名稱") {
                        TextField("必填", text: $food.name)
                            .submitLabel(.next)
                    }
                    LabeledContent("圖示") {
                        TextField("最多輸入兩個字元", text: $food.image)
                            .submitLabel(.next)

                    }
                    
                    buildNumberField(title: "熱量", value: $food.calorie, suffix: "大卡")
                    buildNumberField(title: "蛋白質", value: $food.protein)
                    buildNumberField(title: "脂肪", value: $food.fat)
                    buildNumberField(title: "碳水", value: $food.carb)
                }
                .padding(.top, -16)
                
                Button{ 
                    dismiss()
                    onSubmit(food)
                    
                } label: {
                    Text( invalidMessage ?? "儲存")
                        .frame(maxWidth: .infinity)
                        .bold()
                }
                .mainButtonStyle()
                    .padding()
                    .disabled(isNotValid)
            }
            .background(.groupBG)
            .multilineTextAlignment(.trailing)
            .font(.title3)
            .scrollDismissesKeyboard(.interactively)
        }

        private func buildNumberField(title: String, value: Binding<Double>, suffix: String = "g") -> some View {
            LabeledContent(title) {
                HStack {
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .keyboardType(.decimalPad)
                    Text(suffix)
                }
            }
        }
    }
}

#Preview {
    FoodListView.FoodForm(food: Food.examples.first!) {_ in }
}
