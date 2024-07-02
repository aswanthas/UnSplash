//
//  ContentView.swift
//  UnSplash
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAppActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isAppActive {
            MainView()
        } else {
            VStack {
                VStack {
                    Image("splashImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("Image")
                        .font(Font.custom("Baskerville-Bold", size: 20))
                        .foregroundStyle(.black.opacity(0.5))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.isAppActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
