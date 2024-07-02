//
//  ListCellView.swift
//  UnSplash
//
//  Created by Aswanth K on 02/07/24.
//

import SwiftUI

struct ListCellView: View {
    var data: ImageResponse
    @State var isChecked: Bool = false // Binding to checkbox state
    var onTap: (_ isChecked: Bool) -> Void // Callback for cell tap

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: data.url ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
            .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(data.author ?? "")
                Text("Description")
            }
            
            Spacer()
            Button(action: {
                isChecked.toggle()
                onTap(isChecked)
            }, label: {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .foregroundColor(isChecked ? .blue : .gray)
                    .imageScale(.large)
            })
        }
    }
}
