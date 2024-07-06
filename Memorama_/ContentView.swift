//
//  ContentView.swift
//  Memorama_
//
//  Created by Alejandro Pallares on 05/07/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🦠", "☠️","👻","🎃", "🦠", "☠️","❤️","💀"]
   @State var countCard = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
          cardAdjusters
        }
       
    }
    
    var cards: some View {
        HStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                ForEach(0..<countCard, id: \.self) { index in
                    CardView(content: "\(emojis[index])")
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            
        }
        .padding()
    .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            countCard += offset
        }, label: {
           Image(systemName: symbol)
        })
        .disabled(countCard + offset < 1 || countCard + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding()
    }
    
    struct CardView: View {
        @State var isFaceUp = false
        var content: String
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 10)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    
                    Text(content).font(.largeTitle)
                    
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill(.orange).opacity(isFaceUp ? 0 : 1)
                
            }
            
            .onTapGesture {
                isFaceUp = !isFaceUp
            }
        }
    }
}

#Preview {
    ContentView()
}
