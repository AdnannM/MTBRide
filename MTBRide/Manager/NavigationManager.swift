//
//  NavigationManager.swift
//  MTBRide
//
//  Created by Adnann Muratovic on 12.03.25.
//

import Foundation
import Observation
import SwiftUI

/// A class responsible for managing navigation within the application.
///
/// `NavigationManager` maintains a `NavigationPath` to track the navigation stack.
/// It provides methods for programmatic navigation to specific routes.
@Observable
class NavigationManager {
    /// The navigation path used to track and modify the navigation stack.
    var path = NavigationPath()
    
    /// Navigates to the sign-in screen by appending the `signIn` route to the navigation path.
    func navigateToSignIn() {
        path.append(Route.signIn)
    }
    
    func popBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

/// An enumeration representing various navigation destinations.
///
/// This enum conforms to `Hashable` to be used in `NavigationStack`'s path.
enum Route: Hashable {
    /// Represents the sign-in screen route.
    case signIn
}

/// A view modifier that enables navigation using a `NavigationStack`.
///
/// This modifier integrates a `NavigationManager` into the view hierarchy
/// and provides environment access to manage navigation state.
/// It also defines navigation destinations based on the `Route` enum.
struct RouteRouterViewModifier: ViewModifier {
    /// The navigation manager instance that tracks the navigation state.
    @State private var navigationManager = NavigationManager()
    
    /// Returns a view associated with a given navigation route.
    ///
    /// - Parameter route: The `Route` value determining the destination view.
    /// - Returns: A corresponding `View` instance.
    private func routeView(for route: Route) -> some View {
        Group {
            switch route {
            case .signIn:
                SignIn()
            }
        }
        .environment(navigationManager)
    }
    
    /// Composes the modified view with navigation capabilities.
    ///
    /// - Parameter content: The original view content.
    /// - Returns: A view wrapped in a `NavigationStack` with navigation handling.
    func body(content: Content) -> some View {
        NavigationStack(path: $navigationManager.path) {
            content
                .environment(navigationManager)
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)
                }
        }
    }
}
