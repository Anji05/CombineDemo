//
//  Extensions.swift
//  CombineDemo
//
//  Created by Anjali Aggarwal on 01/10/21.
//

import CoreGraphics

extension Double {
    var toCelsius: String {
        return String(format: "%.0f℃", self - 273.15)
        
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
