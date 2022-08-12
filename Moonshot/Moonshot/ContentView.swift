//
//  ContentView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 10.08.2022.
//

import SwiftUI

struct ContentView: View {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]
    
    var body: some View {
        Text(missions[0].formattedDate)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
