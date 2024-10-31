//
//  MissionView.swift
//  Moonshot
//
//  Created by Basith on 31/10/24.
//

import SwiftUI

struct MissionView: View {
    struct crewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [crewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return crewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing member \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.bottom, 24)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    
                }
                .padding(.horizontal)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBg)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(crew, id: \.role) { member in
                                NavigationLink {
                                    Text("Member Details")
                                } label: {
                                    HStack {
                                        Image(member.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(.capsule)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(member.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(member.role)
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.bottom)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBg)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    NavigationStack {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
