//
//  Astronaut.swift
//  Moonshot
//
//

import Foundation


//struct Astronaut: Codable, Identifiable {
//    let id: String
//    let name: String
//    let description: String
//}

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
