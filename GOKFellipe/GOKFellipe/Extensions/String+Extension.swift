//
//  String+Extension.swift
//  GOKFellipe
//
//  Created by Fellipe Ricciardi Chiarello on 11/7/20.
//

import Foundation

extension String {
    func split(regex pattern: String) -> [String] {

        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
            else { return [] }

        let nsString = self as NSString
        let stop = " "
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
}
