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
struct Cardify: AnimatableModifier {
    
    var rotation: Double //indicates how many degrees the card is rotated
    
    
    //rotation binds to animatableData and takes care of the animation state
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    //Changes the grades depending on whether it is face up or not.
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content //Here falls what wants to be "Cardified"
                .opacity(rotation < 90 ? 1 : 0) //Solve the problem of rotation
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
