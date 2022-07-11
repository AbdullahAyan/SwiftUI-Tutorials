//
//  ContentView.swift
//  Test
//
//  Created by Abdullah Ayan on 11.07.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Spacer()
            Text("saaaaaaaaaaaaaaaaaaaaaaaa")
                
                .foregroundStyle(.ultraThinMaterial)
                    .navigationTitle("")
                    .navigationViewStyle(.automatic)
                    .frame(minWidth: nil, idealWidth: 1000, maxWidth: 1500, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
