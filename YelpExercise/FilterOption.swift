//
//  Filter.swift
//  YelpExercise
//
//  Created by Shajith on 2/16/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import Foundation

class FilterOption {
    
    var label: String
    var value: String
    var selected: Bool
    
    init(label: String, value: String, selected: Bool! = false) {
        self.label = label
        self.value = value
        self.selected = selected
    }
}