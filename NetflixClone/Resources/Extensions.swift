//
//  Extensions.swift
//  NetflixClone
//
//  Created by Macbook Pro on 28.01.2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
