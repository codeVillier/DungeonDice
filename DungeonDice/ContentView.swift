//
//  ContentView.swift
//  DungeonDice
//
//  Created by Oscar De Villiers on 2026/02/24.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        var id: Int { self.rawValue }

        var roll: Int { Int.random(in: 1...rawValue) }
    }
    
    @State private var message = "Roll a die!"
    @State private var animationTrigger = false // changed when animation should occur
    @State private var isDoneAnimating = true
    
    var body: some View {
        VStack {
            Text("Dungeon Dice!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (1, 0, 0))
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false // set to the beginning "false" state right away
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
                ForEach(Dice.allCases) { die in
                    Button("\(die.rawValue)-sided") {
                        animationTrigger.toggle()
                        message = "You rolled a \(die.roll) on a \(die)-sided die."
                    }
                    .font(.title2)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .buttonStyle(.glassProminent)
                    .tint(.red)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
