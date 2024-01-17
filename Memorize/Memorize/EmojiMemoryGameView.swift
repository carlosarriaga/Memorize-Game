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
        
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        //The action of choosing is given to the card.
                        game.choose(card)
                    }
            }
        }//AspectVGrid
                    

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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5).opacity(0.5)
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
    
}//CardView
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //The constant is created to update the previews
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
