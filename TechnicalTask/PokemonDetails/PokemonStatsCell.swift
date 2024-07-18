//
//  PokemonStatsCell.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 18/07/2024.
//

import SwiftUI

struct PokemonStatsCell: View {
    let result : Stat
    var body: some View {
        HStack {
            Text(result.stat?.name?.capitalized ?? "")
                .font(.title)
                .padding()
            Spacer()
            Text(String(result.baseStat ?? 0))
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    PokemonStatsCell(result: Stat.tempData())
}
