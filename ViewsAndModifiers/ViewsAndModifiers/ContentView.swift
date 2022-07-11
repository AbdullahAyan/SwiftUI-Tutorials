//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Abdullah Ayan on 10.07.2022.
//

import SwiftUI

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        NavigationView {
            motto1
            motto2
            spells
        }
        .foregroundStyle(.ultraThinMaterial)

        
    }
    
    @ViewBuilder var spells: some View {
            Text("Lumos")
            Text("Obliviate")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
