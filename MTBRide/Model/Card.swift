//
//  Card.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 10.03.25.
//

import Foundation
import SwiftUI

struct Card: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var image: String
}

let cards: [Card] = [
    .init(image: "image1"),
    .init(image: "image2"),
    .init(image: "image3"),
    .init(image: "image4"),
    .init(image: "image5")
]
