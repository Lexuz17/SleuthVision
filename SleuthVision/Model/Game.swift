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
    var challenges : [Challenge]
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
                    if !item.isDone{
                        itemList.append(item.label)
                    }
                }
                break; // Exit the outer loop once we find a match
            }
        }
        return itemList
    }
    
    func updateItemStatus(itemFound: String, isFound: Bool) {
        for chalIndex in challenges.indices {
            for itemIndex in challenges[chalIndex].items.indices {
                if challenges[chalIndex].items[itemIndex]._class == itemFound {
                    challenges[chalIndex].items[itemIndex].isDone = isFound
                    print("nama: \(itemFound), status: \(isFound)")
                }
            }
        }
        printAllItems()
    }
    
    func printAllItems() {
        for challenge in challenges {
            print("Challenge Location: \(challenge.location.name)")
            for item in challenge.items {
                print("Item: \(item.label), Class: \(item._class), Status: \(item.isDone)")
            }
            print("------")
        }
    }
    
    func UpdateChallenges() {
        for index in challenges.indices {
            let challenge = challenges[index]
            var allItemsDone = true
            
            for item in challenge.items {
                if !item.isDone {
                    allItemsDone = false
                    break
                }
            }
            challenges[index].isDone = allItemsDone
        }
    }
    
    func printAllChallenges() {
        print("All Challenges:")
        for challenge in challenges {
            print("ID: \(challenge.id), Location: \(challenge.location.name), isDone: \(challenge.isDone)")
        }
    }
}

struct Challenge : Identifiable, Hashable {
    var id: Int
    
    let location : Location
    var items : [Item]
    var isDone : Bool
    
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
    var isDone: Bool
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

