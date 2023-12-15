//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Carlos Arriaga on 13/12/23.
//

import Foundation

//Makes the created objects observable by the views
class EmojiMemoryGame: ObservableObject {
    //static - so as not to depend on an instance to access it
    static var emojis = ["🚀","🚁","🏎","🚒","🚗","🚕","🚌","🚓","🚑","🚐","🚜","🛵","🚙","🚎","🛻","🚚","🚛","🛸","⛵️","✈️"]
    
    //model - will be the connection with our model
    //@Published - Ensures that observers are notified of any changes to this property.
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    //Just the connection with the model Cards
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //The deck to be played is created
    static func createMemoryGame() -> MemoryGame<String> {
        //The closing of MemoryGame.init appears here
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in //pairIndex comes from MemoryGame.init
            emojis[pairIndex] //return the emoji for the card in turn
        }
    }
    
    // MARK: Intent
    //Connects to the function of the model
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
