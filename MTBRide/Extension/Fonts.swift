//
//  Fonts.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 09.03.25.
//

import SwiftUI

extension Font {
    /// Display
    static let displayLarge = Font.system(size: 34, weight: .bold, design: .default)
    static let displayMedium = Font.system(size: 28, weight: .bold, design: .default)
    static let displaySmall = Font.system(size: 24, weight: .bold, design: .default)
    
    /// Headings
    static let headingLarge = Font.system(size: 22, weight: .bold, design: .default)
    static let headingMedium = Font.system(size: 17, weight: .semibold, design: .default)
    static let headingSmall = Font.system(size: 15, weight: .semibold, design: .default)
    
    /// Body Text
    static let bodyLarge = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 15, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 13, weight: .regular, design: .default)
    
    /// Labels and Buttons
    static let labelLarge = Font.system(size: 15, weight: .medium, design: .default)
    static let labelMedium = Font.system(size: 13, weight: .medium, design: .default)
    static let labelSmall = Font.system(size: 11, weight: .medium, design: .default)
    
    /// Numeric Display (for metrics)
    static let metricLarge = Font.system(size: 34, weight: .semibold, design: .rounded)
    static let metricMedium = Font.system(size: 24, weight: .semibold, design: .rounded)
    static let metricSmall = Font.system(size: 17, weight: .semibold, design: .rounded)
}
