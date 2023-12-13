//
//  MemoryGame.swift
//  Memorize
//
//  Created by Carlos Arriaga on 13/12/23.
//

import Foundation

struct MemoryGame<CardContent> {
    //It will be the deck of the game
    private(set) var cards: Array<Card>
    
    //createCardContent - Creates a closure, determines the creation of the content of the card
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent ) {
        cards = Array<Card>()
        //Add numberOfPairsOfCards x 2 cards to cards Array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    //The main function of the game
    func choose(_ card: Card) {
        
    }
    
    //It will be the logical structure of the memorize game card.
    struct Card {
        var isFaceUp: Bool = false //To find out if the letter was flipped
        var isMatched: Bool = false //To find out if the letter has found its pair
        /*
         CardContent type does not exist
         It is a "don't care" type. It will help not to be a single type,
         now it will support String type, but in the future it can be Image maybe.
        */
        var content: CardContent
    }
}
