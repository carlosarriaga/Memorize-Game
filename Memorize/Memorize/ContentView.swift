//
//  ContentView.swift
//  Memorize
//
//  Created by Carlos Arriaga on 08/12/23.
//

import SwiftUI


struct ContentView: View {
    var emojis = ["🚀","🚁","🏎","🚒","🚗","🚕","🚌","🚓","🚑","🚐","🚜","🛵","🚙","🚎","🛻","🚚","🚛","🛸","⛵️","✈️"]
    //@State - Declares a property that updates the view when changed.
    @State var emojiCount = 4
    var body: some View {
        VStack {
            
            ScrollView{
                //LazyVGrid - creates a grid that loads cells efficiently,
                //improving performance when displaying large data sets.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    //The cards are loaded and their respective emoji is assigned.
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }//LazyVGrid
            }//ScrollView
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
            
        }//VStack
        .padding(.horizontal)
        .foregroundColor(.red)
    }//Body
    
    
    //Buttons are created to add or subtract cards
    var remove: some View {
        Button {
            //Validated not to go beyond 0
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle") //Apple library icon assigned
        }
    }

    
    var add: some View {
        Button {
            //Validate that it does not exceed the number of emojis in the array.
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle") //Apple library icon assigned
        }
    }
    
}//ContentView


//The main structure of a chart is created
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            //Validates the status of the letter - Open/Closed
            //According to the validation is the view shown (Open or closed)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
            
        }//ZStack
        //The function to be used when a letter is opened has been added.
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
