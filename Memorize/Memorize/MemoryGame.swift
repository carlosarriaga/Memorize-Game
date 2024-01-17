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
    
    
    
    //It will be the logical structure of the memorize game card.
    //The identifiable protocol is used to ensure which card is being played
    struct Card: Identifiable{
        
        var isFaceUp = false //To find out if the letter was flipped
        var isMatched = false //To find out if the letter has found its pair
        let content: CardContent //CardContent - a "Don't care" type (Note below)
        let id: Int
    }
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
