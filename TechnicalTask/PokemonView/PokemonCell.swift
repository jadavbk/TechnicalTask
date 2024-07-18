//
//  PokemonCell.swift
//  TechnicalTask
//
//  Created by Bharat Jadav on 18/07/2024.
//

import SwiftUI

struct PokemonCell: View {
    let result : ResultList
    var body: some View {
        HStack {
            Text(result.name?.capitalized ?? "")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    PokemonCell(result: ResultList.tempData())
}
