//
//  LearnNavigationSwiftUIApp.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

@main
struct LearnNavigationSwiftUIApp: App {
    @State private var routes: [Route] = []
    @State var selection: AppScreen? = .patients

    var body: some Scene {
        WindowGroup {
            ZStack {
                // App-level NavigationStack sadece standalone route'lar için çalışsın
                NavigationStack(path: $routes) {
                    ContentView(selection: $selection)
                }
                .navigationDestination(for: Route.self) { route in
                    route.destination
                }
            }
            .environment(\.navigate, NavigateAction(action: { actionType in
                switch actionType {
                case .push(let route):
                    if route.usesGlobalStack {
                        routes.append(route) // sadece standalone
                    } else {
                        // Tab içi stack'e yönlendirme
                        selection = route.associatedTab
                        NotificationCenter.default.post(name: .customNavigate, object: route)
                    }

                case .pop:
                    _ = routes.popLast()

                case .popToRoot:
                    routes.removeAll()

                case .reset(let newRoutes):
                    routes = newRoutes.filter { $0.usesGlobalStack }
                }
            }))
        }
    }
}
