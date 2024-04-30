//
//  Permission.swift
//  SleuthVision
//
//  Created by mac.bernanda on 28/04/24.
//

import Foundation

class VideoDetectorCoordinator {
    var challengeOb: ChallengeObservable?

    init(challengeOb: ChallengeObservable) {
        self.challengeOb = challengeOb
    }
}

class ChallengeObservable: ObservableObject {
    @Published var detectedItemsLabel: [String: Bool] = [:]

    func resetDetectedItems() {
        detectedItemsLabel = [:]
    }

}
