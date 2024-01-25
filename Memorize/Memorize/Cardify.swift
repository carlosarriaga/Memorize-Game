//
//  Cardify.swift
//  Memorize
//
//  Created by Carlos Arriaga on 22/01/24.
//

import SwiftUI

// Will be in charge of creating the card,
//will place both sides of the card (open/closed).
//She will also modify if the card is flipped over.
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content //Here falls what wants to be "Cardified"
                .opacity(isFaceUp ? 1 : 0) //Solve the problem of rotation 
        }
    }//body
    
    //The values of constants are added together
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
