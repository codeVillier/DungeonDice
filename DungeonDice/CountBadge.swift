//
//  CountBadge.swift
//  DungeonDice
//
//  Created by Oscar De Villiers on 2026/03/21.
//

import SwiftUI

struct CountBadge: View {
    let diceCount: Int
    var body: some View {
        Text("\(diceCount)×")
            .font(.callout)
            .fontWeight(.semibold)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(.red.opacity(0.3), in: Capsule())
            .overlay {
                Capsule().stroke(.red.opacity(0.3), lineWidth: 1)
            }
    }
}

#Preview {
    CountBadge(diceCount: 3)
}
