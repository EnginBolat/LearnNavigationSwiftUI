//
//  PatientDasbboardScreement.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

struct PatientDasbboardView: View {
    @Environment(\.navigate) private var navigate
    
    var body: some View {
        Button("Hasta Detayına Git") {
            navigate(.patient(.detail(Patient(name: "Engin"))))
        }

        Button("Geri Git") {
            navigate.pop() // pop
        }

        Button("Ana Sayfaya Dön") {
            navigate.popToRoot()
        }

        Button("Stack'i Resetle") {
            navigate.reset(to: [.patient(.list), .patient(.detail(Patient(name: "Veli")))])
        }

    }
}
