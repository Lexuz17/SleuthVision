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
	Challenge(id: LocationId.CaveRoom.rawValue, location: caveRoom, items: caveRoomItems, isDone: false),
	Challenge(id: LocationId.Pantry.rawValue, location: pantry, items: pantryItems, isDone: false)
]

let caveRoom = Location(id: LocationId.CaveRoom.rawValue, name: "Cave Room")
var caveRoomItems = [
    Item(label: "person", hints: ["🧢","😷","🧍🏻"], _class: "ber", isDone: false),
    Item(label: "book", hints: ["🍏", "📓", ""], _class: "laptop", isDone: false),
]

let pantry = Location(id: LocationId.Pantry.rawValue, name: "Pantry")
var pantryItems = [
    Item(label: "cup", hints: ["⚙️", "☕️", ""], _class: "coffeeMachine", isDone: false),
    Item(label: "refrigerator", hints: ["↪", "🍜", "🟡"], _class: "cupNoodles", isDone: false),
    Item(label: "apple", hints: ["⌚️", "🟦", ""], _class: "appleWatch", isDone: false)
]

let culprit = Culprit(uuid: "cff3e5c5-057d-11ef-86d3-0242ac120002")

var game0 = Game(
    id: 0,
    title: gameTitle,
    story: scenes,
    challenges: challenges,
    culprit: culprit
)

var games = [game0]
