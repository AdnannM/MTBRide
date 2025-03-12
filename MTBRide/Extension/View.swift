//
//  View.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 12.03.25.
//

import SwiftUI

/// A View extension that applies a routing modifier to the current view.
///
/// This method applies the `RouteRouterViewModifier` to the view,
/// enabling custom routing behavior within the SwiftUI hierarchy.
///
/// - Returns: A modified view with routing capabilities.
extension View {
    func withRouter() -> some View {
        modifier(RouteRouterViewModifier())
    }
}

/// A View extension that applies a blur, opacity, and scale effect based on a boolean condition.
///
/// This modifier is  for animating transitions by making a view
/// appear and disappear smoothly with a blur and scale effect.
///
/// - Parameter show: A Boolean value that determines whether the view
///   should be fully visible (`true`) or blurred and faded out (`false`).
/// - Returns: A modified view with applied blur, opacity, and scale transformations.
extension View {
    func blurOpacityEffect(_ show: Bool) -> some View {
        self
            .blur(radius: show ? 0 : 2)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.9)
    }
}

