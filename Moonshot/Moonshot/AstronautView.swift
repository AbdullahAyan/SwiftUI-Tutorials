//
//  AstronautView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 24.08.2022.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()                        
                    
                    Text(astronaut.description)
                        .padding()
                }
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
