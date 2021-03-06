//
//  ContentView.swift
//  catan dice
//
//  Created by James Robinson on 10/11/2019.
//  Copyright © 2019 James Robinson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let numberFont = 18.0
    let incrementFont = 9.0
    let decrementFont = 12.0
    let doubleFont = 1.0
    let turnFont = 2.0
    let resetFont = 3.0
    let rollFont = 5.0
    
    @ObservedObject var stateModel = GameStateModel()
    
    var body: some View {
        VStack {
            if stateModel.isTurn {
                FrequencyCounter(stateModel: stateModel.frequencyCounter).frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            else {
                Rectangle()
                        .fill(Color.black.opacity(0))
                        .frame(width: 20, height: 50)
            }
            TurnTracker(stateModel: stateModel.turnTracker)
            Text(stateModel.rollValue).scaledFont(name: "Georgia", size: getSize(ratio: numberFont)).frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(stateModel.doubleText).scaledFont(name: "Georgia", size: getSize(ratio: doubleFont)).frame(width: 200, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: stateModel.roll) {
                Text(stateModel.rollAction).scaledFont(name: "Georgia", size: getSize(ratio: decrementFont)).frame(width: 400, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Button(action: stateModel.reset) {
                Text("Reset").scaledFont(name: "Georgia", size: getSize(ratio: resetFont))
            }
        }
    }
    
    func getSize(ratio: Double) -> CGFloat {
        return CGFloat(12.0 * ratio / 1000.0) * UIScreen.main.bounds.size.height
    }
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
