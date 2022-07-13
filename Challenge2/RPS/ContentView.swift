//
//  ContentView.swift
//  RPS
//
//  Created by Abdullah Ayan on 12.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State public var isWin = Bool.random()
    let objects = ["rock","paper","scissors"]
    @State var currentObject = ["rock","paper","scissors"].randomElement()!
    @State var score = 0
    @State var isPresented = false
    @State var clicked = 0 {
        didSet {
            if clicked == 8 {
                isPresented = true
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                
                
                Text(isWin ? "Win": "Lose")
                    .font(.largeTitle)
                    .foregroundColor(isWin ? .yellow : .red)
                
                Spacer()
                
                Image(currentObject)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.largeTitle)
                HStack {
                    ForEach(objects, id: \.self){ object in
                        ZStack{
                            
                            
                            
                            Button {
                                if (trueAnswer(currentObject: currentObject, isWin: isWin) == object) {
                                    score += 1
                                    print("current object:\(currentObject)   |   isWin :\(isWin)   |   trueObject: \(trueAnswer(currentObject: currentObject, isWin: isWin))   |   object: \(object)")
                                    print("score increased")
                                }else{
                                    score -= 1
                                    
                                    print("current object:\(currentObject)   |   isWin :\(isWin)   |   trueObject: \(trueAnswer(currentObject: currentObject, isWin: isWin))   |   object: \(object)")
                                    print("score deacresed")
                                }
                                isWin.toggle()
                                currentObject = objects.randomElement()!
                                clicked += 1
                            } label: {
                                ZStack {
                                    Image(object)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .shadow(radius: 20)
                                }
                            }
                            .buttonStyle(.bordered)
                            .tint(.white)
                        }
                    }
                }
                .alert("Game Over", isPresented: $isPresented) {
                    Button("OK") {
                        
                    }
                    
                } message: {
                    Text("\(score)")
                }
                
                
                
            }
        }
    }
    
    func trueAnswer(currentObject: String,isWin: Bool) -> String {
        switch (currentObject,isWin){
        case ("scissors",true):
            return "rock"
        case ("scissors",false):
            return "paper"
        case ("rock",true):
            return "paper"
        case ("rock",false):
            return "scissors"
        case ("paper",true):
            return "scissors"
        case ("paper",false):
            return "rock"
        default:
            return ""
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


