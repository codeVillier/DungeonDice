//
//  ContentView.swift
//  DungeonDice
//
//  Created by Oscar De Villiers on 2026/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var message = "Roll a die!"
    
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
            
            Spacer()
            
            VStack {
                HStack {
                    Button("4-sided") {
                        rollDie(sides: 4)
                    }
                    Spacer()
                    Button("6-sided") {
                       rollDie(sides: 6)
                    }
                    Spacer()
                    Button("8-sided") {
                        rollDie(sides: 8)
                    }
                }
                HStack {
                    Button("10-sided") {
                        rollDie(sides: 10)
                    }
                    Spacer()
                    Button("12-sided") {
                        rollDie(sides: 12)
                    }
                    Spacer()
                    Button("20-sided") {
                        rollDie(sides: 20)
                    }
                }
                
                Button("100-sided") {
                    rollDie(sides: 100)
                }
                
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .tint(.red)
    
            
        }
        .padding()
    }
    
    func rollDie(sides: Int) {
        let result = Int.random(in: 1...sides)
        message = "You rolled a \(result) on a \(sides)-sided die."
    }
}

#Preview {
    ContentView()
}
