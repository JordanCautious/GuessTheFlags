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
    
    var countryTitle: some View {
        Text(countries[correctAnswer])
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
    
    var currentScore: some View {
        Text("Score: \(score)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .bold()
            .padding(-5)
    }
    
    var flagList: some View {
        ForEach(0..<3) { number in
            Button {
                flagTapped(number)
            } label: {
                Image(countries[number])
                    .renderingMode(.original)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
            .padding(5)
        }
    }
    
    var radial: some View {
        RadialGradient(stops: [
            .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.70, green: 0.2, blue: 0.20), location: 0.3)
        ], center: .top, startRadius: 200, endRadius: 700)
        .ignoresSafeArea()
    }
    
    var titles = Titles()
    var body: some View {
        ZStack {
            radial
            VStack {
                Spacer()
                titles.title
                Spacer()
                BoxView()
                Spacer()
                currentScore
                Spacer()
            }
            .padding(10)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
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

struct Titles {
    let title = Text("Guess The Flag!")
        .foregroundColor(.white)
        .font(.largeTitle)
        .bold()
    
    let boxTitle = Text("Tap the flag of")
        .font(.title2)
        .bold()
}

struct BoxView: View {
    var body: some View {
        VStack (spacing: 15.0) {
            VStack {
                Titles().boxTitle
                Divider()
                    .padding(-5.0)
                ContentView().countryTitle
            }
            ContentView().flagList
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
