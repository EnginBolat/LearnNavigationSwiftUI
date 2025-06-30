//
//  DoctorRoute.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

enum DoctorRoute: Hashable {
    case list
    case create
    case detail(Doctor)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .create: Text("DoctorRoute Create")
        case .list: Text("DoctorRoute List")
        case .detail(let doctor): Text("Doctor detais for \(doctor.name)")
        }
    }
    
    var usesGlobalStack: Bool {
        switch self {
        case .list: return false // TabView içindeki NavigationStack'te gösterilecek
        case .create, .detail: return true // App seviyesindeki NavigationStack'te gösterilecek
        }
    }
}

struct DoctorNavigationStack: View {
    @State private var routes: [DoctorRoute] = []
    
    var body: some View {
        NavigationStack(path: $routes) {
            DoctorDasbboardView()
                .navigationDestination(for: DoctorRoute.self) { route in
                    route.destination
                }
        }.environment(\.navigate, NavigateAction(action: { actionType in
            switch actionType {
            case .push(let route):
                if case let .doctor(DoctorRoute) = route {
                    routes.append(DoctorRoute)
                }
            case .pop:
                if !routes.isEmpty {
                    routes.removeLast()
                }
            case .popToRoot:
                routes = []
            case .reset(let newRoutes):
                let doctorRoutes = newRoutes.compactMap { route -> DoctorRoute? in
                    if case let .doctor(d) = route {
                        return d
                    }
                    return nil
                }
                routes = doctorRoutes
            }
        }))
        .onReceive(NotificationCenter.default.publisher(for: .customNavigate)) { notification in
            guard let route = notification.object as? Route else { return }
            if case let .doctor(doctorRoute) = route {
                routes.append(doctorRoute)
            }
        }
    }
}
