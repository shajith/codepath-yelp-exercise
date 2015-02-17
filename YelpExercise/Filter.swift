//
//  Filter.swift
//  YelpExercise
//
//  Created by Shajith on 2/16/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import Foundation

class Filter {
    var label: String
    var name: String
    var options: Array<FilterOption>
    var type: FilterType
    
    init(label: String, name: String, options: Array<FilterOption>, type: FilterType) {
        self.label = label
        self.name = name
        self.options = options
        self.type = type
    }
}

enum FilterType {
    case Single
    case Multiple
    case Boolean
}