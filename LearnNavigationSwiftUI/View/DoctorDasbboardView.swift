//
//  DoctorDasbboardView.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

struct DoctorDasbboardView: View {
    @Environment(\.navigate) private var navigate
    
    var body: some View {
        Button("Doktor Detayına Git") {
            navigate(.doctor(.detail(Doctor(name: "Engin"))))
        }

        Button("Geri Git") {
            navigate.pop()
        }

        Button("Ana Sayfaya Dön") {
            navigate.popToRoot()
        }

        Button("Stack'i Resetle") {
            navigate.reset(to: [.doctor(.list), .doctor(.detail(Doctor(name: "Veli")))])
        }

    }
}
