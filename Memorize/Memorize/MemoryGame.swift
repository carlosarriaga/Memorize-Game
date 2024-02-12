//
//  MemoryGame.swift
//  Memorize
//
//  Created by Carlos Arriaga on 13/12/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    //It will be the deck of the game
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            //The filter function is used to find the first card isFaceUp = true
            //Extension created to return to oneAndOnly Card
            cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }//Get
        set {
            //Cards are turned over when arent the same as a card already opened
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }//Set
    }//indexOfTheOneAndOnlyFaceUpCard
    
    //createCardContent - Creates a closure, determines the content of the card.
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent ) {
        cards = []
        //Add numberOfPairsOfCards x 2 cards to cards Array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    //Game logic
    //The main function of the game
    mutating func choose(_ card: Card) {
        //Search for the chosen card in deck
        //Validate that it's not face up and has no match
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {   //if it is a second card, it becomes a potential match
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                //If the comparison is successful
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                //If it is the first card, it is stored in indexOfTheOneAndOnlyFaceUpCard
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }//Func
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    
    //It will be the logical structure of the memorize game card.
    //The identifiable protocol is used to ensure which card is being played
    struct Card: Identifiable{
        
        //To find out if the letter was flipped
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        //To find out if the letter has found its pair
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent //CardContent - a "Don't care" type (Note below)
        let id: Int
        
        
        
         
        // MARK: - Bonus Time
                
                // this could give matching bonus points
                // if the user matches the card
                // before a certain amount of time passes during which the card is face up
                
                // can be zero which means "no bonus available" for this card
                var bonusTimeLimit: TimeInterval = 6
                
                // how long this card has ever been face up
                private var faceUpTime: TimeInterval {
                    if let lastFaceUpDate = self.lastFaceUpDate {
                        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                    } else {
                        return pastFaceUpTime
                    }
                }
                // the last time this card was turned face up (and is still face up)
                var lastFaceUpDate: Date?
                // the accumulated time this card has been face up in the past
                // (i.e. not including the current time it's been face up if it is currently so)
                var pastFaceUpTime: TimeInterval = 0
                
                // how much time left before the bonus opportunity runs out
                var bonusTimeRemaining: TimeInterval {
                    max(0, bonusTimeLimit - faceUpTime)
                }
                // percentage of the bonus time remaining
                var bonusRemaining: Double {
                    (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
                }
                // whether the card was matched during the bonus time period
                var hasEarnedBonus: Bool {
                    isMatched && bonusTimeRemaining > 0
                }
                // whether we are currently face up, unmatched and have not yet used up the bonus window
                var isConsumingBonusTime: Bool {
                    isFaceUp && !isMatched && bonusTimeRemaining > 0
                }
                
                // called when the card transitions to face up state
                private mutating func startUsingBonusTime() {
                    if isConsumingBonusTime, lastFaceUpDate == nil {
                        lastFaceUpDate = Date()
                    }
                }
                // called when the card goes back face down (or gets matched)
                private mutating func stopUsingBonusTime() {
                    pastFaceUpTime = faceUpTime
                    self.lastFaceUpDate = nil
                }
        
    }//Card
}


//Returns the only value in an array
//In the game: Return the card that is face up.
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}










/*
 CardContent type does not exist
 It is a "don't care" type. It will help not to be a single type,
 now it will support String type, but in the future it can be Image maybe.
*/
