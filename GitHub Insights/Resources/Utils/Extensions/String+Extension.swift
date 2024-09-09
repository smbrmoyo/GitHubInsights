//
//  String+Extension.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import Foundation

extension String {
    
    /**
     Checks if a String is conform to an array of regexes
     
     - parameter regexes An array of `String` values where each string is a regular expression pattern.
     - returns  A `Bool` indicating whether the current object matches any of the provided regular expressions.
     */
    func isValid(regexes: [String]) -> Bool {
        for regex in regexes {
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            if predicate.evaluate(with: self) == true {
                return true
            }
        }
        return false
    }
}
