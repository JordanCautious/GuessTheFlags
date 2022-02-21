//
//  ContentView.swift
//  GuessTheFlags
//
//  Created by Jordan Haynes on 1/19/22.
//

import SwiftUI

struct ContentView: View {
    // Varibles needed for the project
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let title = Text("Guess The Flag!")
    let boxTitle = Text("Tap the flag of...")
    
    // Body of the view
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.70, green: 0.2, blue: 0.20), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                // Title
                VStack {
                    title
                    .foregroundColor(.white)
                }
                .font(.largeTitle.bold())
                
                Spacer()
                
                // Box of flags
                VStack (spacing: 15.0) {
                    VStack {
                        // Title of box and country
                        boxTitle
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    
                    // List of flags
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        }
                        .padding(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                // Current Score
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding(-5)
                
                Spacer()
                
                
            }
            .padding(10)
        }
        // Alert notifcation if the user guesses correctly
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }

    // Functions needed for the project
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)

    }
}
