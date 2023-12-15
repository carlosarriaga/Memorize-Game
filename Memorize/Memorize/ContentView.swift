//
//  ContentView.swift
//  Memorize
//
//  Created by Carlos Arriaga on 08/12/23.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
            
            ScrollView{
                //LazyVGrid - creates a grid that loads cells efficiently,
                //improving performance when displaying large data sets.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    //The cards are loaded and their respective emoji is assigned.
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                //The action of choosing is given to the card.
                                viewModel.choose(card)
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
    let card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            //Validates the status of the letter - Open/Closed
            //According to the validation is the view shown (Open or closed)
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched { //If the cards match, they disappear from the board.
                shape.opacity(0)
            } else {
                shape.fill()
            }
            
        }//ZStack
    }
}//CardView
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //The constant is created to update the previews
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
