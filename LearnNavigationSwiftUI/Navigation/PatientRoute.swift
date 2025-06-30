//
//  PatientRoute.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI


enum PatientRoute: Hashable {
    case list
    case create
    case detail(Patient)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .create: Text("PatientRoute Create")
        case .list: Text("PatientRoute List")
        case .detail(let patient): Text("Patient detais for \(patient.name)")
        }
    }
    
    var usesGlobalStack: Bool {
        switch self {
        case .list, .detail: return false // TabView içindeki NavigationStack'te gösterilecek
        case .create : return true // App seviyesindeki NavigationStack'te gösterilecek
        }
    }
}

struct PatientNavigationStack: View {
    @State private var routes: [PatientRoute] = []
    
    var body: some View {
        NavigationStack(path: $routes) {
            PatientDasbboardView()
                .navigationDestination(for: PatientRoute.self) { route in
                    route.destination
                }
        }.environment(\.navigate, NavigateAction(action: { actionType in
            switch actionType {
            case .push(let route):
                if case let .patient(patientRoute) = route {
                    routes.append(patientRoute)
                }
            case .pop:
                if !routes.isEmpty {
                    routes.removeLast()
                }
            case .popToRoot:
                routes = []
            case .reset(let newRoutes):
                let patientRoutes = newRoutes.compactMap { route -> PatientRoute? in
                    if case let .patient(r) = route {
                        return r
                    }
                    return nil
                }
                routes = patientRoutes
            }
        }))
        .onReceive(NotificationCenter.default.publisher(for: .customNavigate)) { notification in
            guard let route = notification.object as? Route else { return }
            if case let .patient(patientRoute) = route {
                routes.append(patientRoute)
            }
        }
    }
}
