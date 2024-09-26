//
//  Date+Extension.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 21.09.24.
//

import Foundation

extension Date {
    /**
     Function to find the date a week previously
     */
    static func getDateForLastWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = Calendar.current
        if let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) {
            return dateFormatter.string(from: sevenDaysAgo)
        }
        
        return dateFormatter.string(from: Date())
    }
    
    
    /**
     Function to convert an ISO 8601 date string to "days, hours, minutes ago" format
     - parameter isoDateString Date `String` to convert
     - returns formatted data
     */
    static func timeAgoSinceDate(_ isoDateString: String) -> String {
        
        let isoDateFormatter = ISO8601DateFormatter()
        
        guard let date = isoDateFormatter.date(from: isoDateString) else {
            return "0 m ago"
        }
                
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }

}
