//
//  Pie.swift
//  Memorize
//
//  Created by Carlos Arriaga on 17/01/24.
//

import SwiftUI


struct Pie: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    //Shape protocol implementation
    func path(in rect: CGRect) -> Path {
        
        //Center is calculated, it is based on the card where it will be created to calculate it.
        let center = CGPoint(x: rect.midX, y: rect.midY)
        //The radius is calculated taking into account the width and height of the card.
        let radius = min(rect.width, rect.height) / 2
        //A starting from the center, the starting point (90 degrees) is calculated.
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        //Paths is created
        var p = Path()
        //from the center...
        p.move(to: center)
        p.addLine(to: start)
        //creates de circle
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise //clockwise must be reversed
        )
        //ends the pie
        p.addLine(to: center)
        
        return p
    }
    
}//Pie
