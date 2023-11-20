//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by yoway Li on 2023/11/20.
//

import SwiftUI

@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String  {
        wrappedValue.formatted() + suffix
    }
}
