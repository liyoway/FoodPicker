//
//  FoodForm.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/12/12.
//

import SwiftUI

extension FoodListView {
    struct FoodForm: View {
        @State var food : Food
        var body: some View {
           VStack {
                Label("編輯食物資訊", systemImage: "pencil")
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                
                Form {
                    LabeledContent("名稱") {
                        TextField("必填", text: $food.name )
                    }
                    LabeledContent("圖示") {
                        TextField("最多輸入兩個字元", text: $food.image )
                    }
                    LabeledContent("名稱") {
                        HStack{
                            TextField("", value: $food.calorie, format:
                                    .number.precision(.fractionLength(1)))
                            Text("大卡")
                        }
                    }
                }
            }
           .background(.groupBG)
           .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    FoodListView.FoodForm(food: Food.examples.first!)
}
