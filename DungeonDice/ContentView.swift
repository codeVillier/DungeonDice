//
//  ContentView.swift
//  DungeonDice
//
//  Created by Oscar De Villiers on 2026/02/24.
//

import SwiftUI

struct ContentView: View {
    
    struct DieGroup: Identifiable {
        var id: Int
        
        let dieLabel: String
        let value: Int
        
        var rollValues: [Int] = []
        
        var rollString: String {
            rollValues.map { "\($0)" }.joined(separator: ", ") // Creates comma-separated String from rollValues elements
        }
        
        var subTotal: Int { rollValues.reduce(0, +) } // Adds up all of the values in rollValues
        
    }
    
    enum Dice: Int, CaseIterable, Identifiable {
        case d4 = 4, d6 = 6, d8 = 8, d10 = 10, d12 = 12, d20 = 20, d100 = 100
        
        var id: Int { self.rawValue }

        var roll: Int { Int.random(in: 1...rawValue) }
    }
    
    @State private var message = "Roll a die!"
    @State private var animationTrigger = false // changed when animation should occur
    @State private var isDoneAnimating = true
    @State private var dieGroups: [DieGroup] = []
    private var grandTotal: Int { dieGroups.reduce(0, {$0 + $1.subTotal}) }
    
    var body: some View {
        VStack {
            Text("Dungeon Dice!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            GroupBox {
                ForEach(dieGroups) { dieGroup in
                    HStack {
                        Text("\(dieGroup.dieLabel) - ")
                        
                        Text(dieGroup.rollString)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("\(dieGroup.subTotal)")
                            
                    }
                    .font(.title3)
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .animation(.default, value: dieGroup.subTotal)
                    
                    Divider()
                }
                
                HStack {
                    Text("TOTAL: \(grandTotal)")
                        .font(.title2)
                        .bold()
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .animation(.default, value: grandTotal)
                    
                    Spacer()
                    Button("Clear") {
                        dieGroups.removeAll()
                    }
                    .buttonStyle(.glass)
                    .tint(.red)
                    .disabled(dieGroups.isEmpty)
                }
            } label: {
                Text("Session Rolls:")
                    .font(.title2)
                    .bold()
            }

            
            Spacer()
            
            Text(message)
                .font(.title)
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
                        let roll = die.roll
                        message = "You rolled a \(roll) on a \(die)."
                        
                        // Two cases of append
                        // The dieGroup is already in dieGroup (e.g. you've already rolled that type of die. And if that's the case, we just want to append the new roll to the end of the roll property
                        // OR
                        // We need to create a new DieGroup, adding the roll as the only / first element of the .rolls array of that DieGroup
                        
                        // Check if the DieGroup for the die rolled is in the dieGroups list:
                        if let index = dieGroups.firstIndex(where: { $0.id == die.rawValue}) {
                            dieGroups[index].rollValues.append(roll) // if DieGroup for this die is in the list, just add the roll to it's rollValues array
                        } else { // otherwise
                            dieGroups.append(DieGroup(id: die.rawValue, dieLabel: "\(die)", value: roll, rollValues: [roll])) // Create the DieGroup for that button, which has'nt been previously pressed
                        }
                        dieGroups.sort { $0.id < $1.id }
                        
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
