//
//  ContentView.swift
//  Memorize
//
//  Created by Carlos Arriaga on 08/12/23.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
            
            ScrollView{
                //LazyVGrid - creates a grid that loads cells efficiently,
                //improving performance when displaying large data sets.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    //The cards are loaded and their respective emoji is assigned.
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                //The action of choosing is given to the card.
                                game.choose(card)
                            }
                    }
                }//LazyVGrid
            }//ScrollView
            
        
        .padding(.horizontal)
        .foregroundColor(.red)
    }//Body
}//ContentView








//The main structure of a chart is created
struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                //Validates the status of the letter - Open/Closed
                //According to the validation is the view shown (Open or closed)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.white)
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched { //If the cards match, they disappear from the board.
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }//ZStack
        } //GeometryReader
    }//Body
    
    
    
    
    //Calculate the size of emoji size regardless of card size
    //Makes the declarative area cleaner
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    
    
    
    //The values of constants are added together
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
    
}//CardView
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //The constant is created to update the previews
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
