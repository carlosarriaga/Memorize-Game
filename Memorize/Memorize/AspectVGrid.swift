//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Carlos Arriaga on 04/01/24.
//

import SwiftUI

//Add Item and ItemView as "Don't care" types.
//ItemView will behave like View (CardView)
struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    
    
    var items: [Item]
    var aspectRatio: CGFloat
    //content: function type. receives an item (card) and returns an ItemView (CardView).
    var content: (Item) -> ItemView
    
    
    //@escaping - to let use the closure out of the init context
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView){
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    var body: some View {
        //Apply the geometryreader
        GeometryReader { geometry in
            VStack{
                //use the function widthThatFits to calculate the size of the cards
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }//VStack
            Spacer(minLength: 0)
        }//GeometryReader
    }//Body
    
    
    //function to set .spacing to 0
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeigth = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeigth < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }//widthThatFits
    
    
    
}//AspectVGrid








//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}



