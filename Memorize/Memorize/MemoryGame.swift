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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    //createCardContent - Creates a closure, determines the content of the card.
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent ) {
        cards = Array<Card>()
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
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {   //if it is a second card, it becomes a potential match
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                //If the comparison is successful
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                //The card is restarted
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                //Cards are turned over again
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                //If it is the first card, it is stored in indexOfTheOneAndOnlyFaceUpCard
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //The chosen card is turned over
            cards[chosenIndex].isFaceUp.toggle()
        }
    }//Func
    
    
    
    //It will be the logical structure of the memorize game card.
    //The identifiable protocol is used to ensure which card is being played
    struct Card: Identifiable{
        
        var isFaceUp: Bool = false //To find out if the letter was flipped
        var isMatched: Bool = false //To find out if the letter has found its pair
        var content: CardContent //CardContent - a "Don't care" type (Note below)
        var id: Int
    }
}

/*
 CardContent type does not exist
 It is a "don't care" type. It will help not to be a single type,
 now it will support String type, but in the future it can be Image maybe.
*/
