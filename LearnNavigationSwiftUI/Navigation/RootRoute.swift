//
//  Root.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case patients
    case doctors
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .patients:
            Label("Patients", systemImage: "heart")
        case .doctors:
            Label("Doctors", systemImage: "star")
        }
    }
    
    @ViewBuilder
    var destionation: some View {
        switch self {
        case .patients:
            PatientNavigationStack()
        case .doctors:
            DoctorNavigationStack()
        }
    }
}

enum Route: Hashable {
    case patient(PatientRoute)
    case doctor(DoctorRoute)
    
    var associatedTab: AppScreen {
        switch self {
        case .patient: return .patients
        case .doctor: return .doctors
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .patient(let patientRoute): patientRoute.destination
        case .doctor(let doctorRoute): doctorRoute.destination
        }
    }
    
    var usesGlobalStack: Bool {
           switch self {
           case .patient(let route): return route.usesGlobalStack
           case .doctor(let route): return route.usesGlobalStack
           }
       }
}

