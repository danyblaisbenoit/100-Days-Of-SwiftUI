//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Dany Blais Benoit on 2025-01-06.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackGround)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}
