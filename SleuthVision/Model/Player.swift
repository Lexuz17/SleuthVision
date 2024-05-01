//
//  Player.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import Foundation

class Player: Codable {
    var name: String
    var roomProgress: [Int: Progress] // Kemajuan per ruangan, dengan ID ruangan sebagai kunci
    var completedTasksPerRoom: [Int: Int] // Jumlah tugas yang telah diselesaikan oleh pemain di setiap ruangan
    var tasksDone: [Int] // Daftar tugas pemain
    
    init(name: String, roomProgress: [Int: Progress] = [:], completedTasksPerRoom: [Int: Int] = [:], tasksDone: [Int] = []) {
        self.name = name
        self.roomProgress = roomProgress
        self.completedTasksPerRoom = completedTasksPerRoom
        self.tasksDone = tasksDone
    }
}

enum Progress:Codable {
    case notStarted
    case inProgress
    case completed
}
