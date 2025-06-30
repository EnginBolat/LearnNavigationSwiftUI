//
//  NavigateRoot.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

struct NavigateAction {
    enum ActionType {
        case push(Route)
        case pop
        case popToRoot
        case reset([Route])
    }
    
    typealias Action = (ActionType) -> ()
    let action: Action
    
    func callAsFunction(_ route: Route) {
        action(.push(route))
    }
    
    func pop() {
        action(.pop)
    }

    func popToRoot() {
        action(.popToRoot)
    }

    func reset(to routes: [Route]) {
        action(.reset(routes))
    }
}

struct NavigateEnviromentKey: EnvironmentKey {
    static let defaultValue: NavigateAction = NavigateAction { _ in }
}

extension EnvironmentValues {
    var navigate: (NavigateAction) {
        get { self[NavigateEnviromentKey.self] }
        set { self[NavigateEnviromentKey.self] = newValue }
    }
}

