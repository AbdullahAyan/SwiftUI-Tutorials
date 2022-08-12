//
//  Mission.swift
//  Moonshot
//
//  Created by Abdullah Ayan on 11.08.2022.
//

import Foundation



struct Mission: Codable,Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var formattedDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
