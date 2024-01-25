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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }//ZStack
            .cardify(isFaceUp: card.isFaceUp)//A the form Pie and the content (emoji) is applied to the card form
        } //GeometryReader
    }//Body
    
    
    
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    
    
    //The values of constants are added together
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.75
        static let fontSize: CGFloat = 32
    }
    
}//CardView
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //The constant is created to update the previews
        let game = EmojiMemoryGame()
//        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
