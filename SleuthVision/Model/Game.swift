//
//  Game.swift
//  SleuthVision
//
//  Created by mac.bernanda on 27/04/24.
//

import Foundation

class Game {
    let id : Int
    let title : String
    let story : [Story]
    let challenges : [Challenge]
    let culprit : Culprit
    var itemDictionary : [String: Item] = [:]
    
    init(id: Int, title: String, story: [Story], challenges: [Challenge], culprit: Culprit) {
        self.id = id
        self.title = title
        self.story = story
        self.challenges = challenges
        self.culprit = culprit
        
        for chal in challenges {
            for item in chal.items {
                itemDictionary[item.label] = item
            }
        }
    }
    
    func getItemList(locationId: Int) -> [String] {
        var itemList: [String] = []
        
        // Iterate through challenges
        for challenge in challenges {
            // Check if the challenge location's UUID matches
            if challenge.location.id == locationId {
                for item in challenge.items {
                    itemList.append(item.label)
                }
                break; // Exit the outer loop once we find a match
            }
        }
        
        return itemList
    }
}

struct Challenge : Identifiable, Hashable {
    var id: Int
    
    let location : Location
    let items : [Item]
    
    static func == (lhs: Challenge, rhs: Challenge) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.id)
    }
}

struct Item {
    let label : String
    let hints : [String]
    let _class : String
}

//struct Hint {
//    let images : String
//}

struct Location{
    let id : Int
    let name : String
}

struct Story {
    let image : String
    let description : String
}

struct Culprit {
//    let image : String
    let uuid : String
}

