//
//  ContentView.swift
//  WordScramble
//
//  Created by Abdullah Ayan on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Score: \(score)")
                }
                Section("Enter your word") {
                    TextField("Enter your word", text: $newWord)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK",role: .cancel) {}
            }message: {
                Text(errorMessage)
            }.toolbar {
                Button("Start Game"){
                    startGame()
                    usedWords.removeAll()
                    score = 0
                }
            }
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .navigationTitle(rootWord)
        }
    }
    
    
    
    func addWord(){
        rootWord = rootWord.lowercased()
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 3 else {
            wordError(title: "Too Short", message: ":)")
            rootWord = rootWord.capitalized
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            rootWord = rootWord.capitalized
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            rootWord = rootWord.capitalized
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            rootWord = rootWord.capitalized
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        rootWord = rootWord.capitalized
        score += answer.count
    }
    
    
    func startGame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement()?.capitalized ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    func isOriginal(word: String) -> Bool {
        return !(usedWords.contains(word) || rootWord == word)
    }
    
    
    func isPossible(word: String) -> Bool {
        var temp = rootWord
        for letter in word {
            if let pos = temp.firstIndex(of: letter) {
                temp.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
