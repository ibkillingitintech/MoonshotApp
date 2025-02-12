//
//  MissionView.swift
//  Moonshot
//
//

import SwiftUI


struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .transition(.scale) // Adds scale transition
                        .animation(.easeInOut(duration: 0.5), value: mission.image) // Adds animation
                        .padding(.top)
                VStack(alignment: .leading){
                    
                    
                    Text("Misson Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        .foregroundColor(.orange)
                    Text(mission.formattedLaunchDate)
                        .font(.subheadline.bold())
                        .padding(.bottom, 5)
                        .transition(.slide)
                    Text(mission.description)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                Rectangle()
                    .frame(height: 2)
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        .padding(.vertical)
                Text("Crew")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(Capsule().strokeBorder(.white, lineWidth: 1))
                                        .shadow(radius: 5) // Adds shadow

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .shadow(radius: 5)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                                .background(.lightBackground) // Adds background
                                .cornerRadius(10) // Adds rounded corners
                                .shadow(radius: 5) // Adds shadow to the card
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.orange, lineWidth: 2) // Adds orange border
                                        .shadow(color: .orange, radius: 10) // Adds glow effect
                                )
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground)) // Auto-adjusts between light and dark mode

    }
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
       let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

       return MissionView(mission: missions[0], astronauts: astronauts)
           .preferredColorScheme(.dark)
}
