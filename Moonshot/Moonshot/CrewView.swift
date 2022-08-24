//
//  CrewView.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 24.08.2022.
//

import SwiftUI

struct CrewView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72, alignment: .center
                                )
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white,lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(member.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
