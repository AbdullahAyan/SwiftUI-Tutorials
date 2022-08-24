//
//  ListView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 24.08.2022.
//

import SwiftUI

struct ListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, alignment: .center
                            )
                            .padding()
                        Text(mission.displayName)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListView(missions: missions, astronauts: astronauts)
    }
}
