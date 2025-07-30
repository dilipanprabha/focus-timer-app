//
//  Session.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import Foundation

struct Session: Codable, Hashable, Identifiable {
    let id: UUID
    let duration: Int
    var completed: Date
    let isFinished: Bool
}
