//
//  GameInstance.swift
//  SleuthVision
//
//  Created by mac.bernanda on 27/04/24.
//

import Foundation

let gameTitle = "Case I"

enum LocationId : Int {
    case CaveRoom = 0
    case Pantry = 1
}

let scenes = [
    Story(image: "sceneA.jpg", description: ""),
    Story(image: "sceneB.jpg", description: "")
]

let challenges = [
    Challenge(id: LocationId.CaveRoom.rawValue, location: caveRoom, items: caveRoomItems),
    Challenge(id: LocationId.CaveRoom.rawValue, location: pantry, items: pantryItems)
]

let caveRoom = Location(id: 0, name: "Cave Room")
let caveRoomItems = [
    Item(label: "person", hints: ["🧑🏻‍💻","🧍🏻","👓"], _class: "rizkuy"),
    Item(label: "laptop", hints: ["🟨", "🙂", ""], _class: "smilyOnPostkit"),
]

let pantry = Location(id: 1, name: "Pantry")
let pantryItems = [
    Item(label: "cup", hints: ["⚙️", "☕️", ""], _class: "coffeeMachine"),
    Item(label: "spoon", hints: ["🥇", "", ""], _class: "goldenSpoon"),
    Item(label: "apple", hints: ["⌚️", "🟦", ""], _class: "appleWatch")
]

let culprit = Culprit(uuid: "cff3e5c5-057d-11ef-86d3-0242ac120002")

let game0 = Game(
    id: 0,
    title: gameTitle,
    story: scenes,
    challenges: challenges,
    culprit: culprit
)

let games = [game0]
