//
//  ContentView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 10.08.2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGrid = true
    @State private var switchGridTo = "List"
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar {
                Button(switchGridTo) {
                    if showingGrid {
                        withAnimation(.easeInOut) {
                            showingGrid = false
                        }
                        switchGridTo = "Grid"
                    } else {
                        withAnimation(.easeInOut) {
                            showingGrid = true
                        }
                        switchGridTo = "List"
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
