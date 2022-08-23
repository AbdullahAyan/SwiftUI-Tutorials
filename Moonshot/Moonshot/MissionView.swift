//
//  MissionView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 23.08.2022.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
    
    var astronauts: [String : Astronaut] {
        return Bundle.main.decode("astronauts.json")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.height * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom,5)
                        
                        Text(mission.description)
                        
                        List {
                            ForEach(mission.crew, id: \.name) { member in
                                Text("1")
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.large)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
