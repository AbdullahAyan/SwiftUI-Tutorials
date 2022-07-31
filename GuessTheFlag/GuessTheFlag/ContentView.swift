//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abdullah Ayan on 9.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCount = 1
    @State private var animationAmount = 0.0
    @State private var tappedFlag: Int?
    @State private var opacity = 1.0
    @State private var scaleAmount = 1.0
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    ForEach(0..<3){number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(tappedFlag == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(tappedFlag == number ? 1 : opacity)
                        .scaleEffect(tappedFlag == number ? 1 : scaleAmount)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore){
                if questionCount == 8 {
                    Button("Restart"){
                        askQuestion()
                        questionCount = 0
                    }
                }else {
                    Button("Countinue",action: askQuestion)
                }
            } message: {
                Text("Your score is \(score)")
            }
            
        }
    }
    
    func flagTapped(_ number: Int){
        tappedFlag = number
        if questionCount == 8 {
            scoreTitle = "Game Over"
            showingScore = true
            return
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! \nThat’s the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
        withAnimation {
            animationAmount += 360
            opacity *= 1/4
        }
        withAnimation(.easeInOut) {
            scaleAmount = 0.0
        }
        
    }
    
    func askQuestion(){
        animationAmount = 0
        opacity = 0
        if questionCount == 8 {
            score = 0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacity = 1.0
        withAnimation(.easeInOut) {
            scaleAmount = 1.0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule(style: .continuous))
            .shadow(color: .cyan, radius: 5, x: 0, y: 0)
    }
}
