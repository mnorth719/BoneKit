//
//  StringExtensions.swift
//  BoneKit
//
//  Created by Matt North on 9/30/17.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
