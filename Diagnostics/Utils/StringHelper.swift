//
//  StringHelper.swift
//  Diagnostics
//
//  Created by Diego Menecheli on 16/03/24.
//

import Foundation

struct StringHelper {
    public func convertDateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    public func convertStringToDate(dateStr: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateStr)
    }
}
