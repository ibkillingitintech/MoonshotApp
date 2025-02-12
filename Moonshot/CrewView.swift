//
//  CrewView.swift
//  Moonshot
//
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]
    var body: some View {
        HStack {
            ForEach(crew, id: \.role) { crewMember in
                NavigationLink {
                    Text("Astronaut details")
                } label: {
                    HStack {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let crew = [
            CrewMember(role: "Commander", astronaut: astronauts["armstrong"]!)
        ]
    
        CrewView(crew: crew)
    .preferredColorScheme(.dark)
}
