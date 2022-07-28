//
//  ContentView.swift
//  Animations
//
//  Created by Abdullah Ayan on 27.07.2022.
//

import SwiftUI

/* MARK: - Attaching animation to View
 struct ContentView: View {
 
 @State private var animationAmount = 1.0
 
 var body: some View {
 Button("Tap Me!") {
 animationAmount += 1
 }
 .padding(50)
 .background(.red)
 .foregroundColor(.white)
 .clipShape(Circle())
 .overlay(
 Circle()
 .stroke(.red)
 .scaleEffect(animationAmount)
 .opacity(2-animationAmount)
 .animation(
 .easeOut(duration: 1)
 .repeatForever(autoreverses: false),
 value: animationAmount
 )
 )
 .onAppear(){
 animationAmount = 2
 }
 
 
 }
 }
 */

/* MARK: - Attaching animation to state variables
 struct ContentView: View {
 
 @State private var animationAmount = 1.0
 
 var body: some View {
 print(animationAmount)
 
 return VStack {
 Stepper("Scale Amount", value: $animationAmount.animation(
 .easeInOut(duration: 1)
 .repeatCount(3, autoreverses: true)
 ), in: 1...10)
 
 Spacer()
 
 Button("Tap Me!") {
 animationAmount += 1
 }
 .padding(40)
 .background(.red)
 .foregroundColor(.white)
 .clipShape(Circle())
 .scaleEffect(animationAmount)
 
 }
 
 }
 }
 */

//MARK: - Animating with withAnimation()
//struct ContentView: View {
//
//    @State private var animationAmount = 0.0
//
//    var body: some View {
//        Button("Tap Me") {
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                animationAmount += 360
//            }
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
//    }
//}


/* MARK: - animate() modifiers orders matter. with those we can animate seperated situations with different animations.
 struct ContentView: View {
 
 @State private var enabled = false
 
 var body: some View {
 Button("Tap Me") {
 enabled.toggle()
 }
 .frame(width: 200, height: 200)
 .background(enabled ? .blue : .red)
 .animation(.default, value: enabled)
 .foregroundColor(.white)
 .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
 .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
 }
 */


/* MARK: - This cause to animate one situation and pass desired changes
 Button("Tap Me") {
 enabled.toggle()
 }
 .frame(width: 200, height: 200)
 .background(enabled ? .blue : .red)
 .animation(nil, value: enabled)
 .foregroundColor(.white)
 .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
 .an
 }
 */

//MARK: - Animating Gestures

/* Dragging a card
 struct ContentView: View {
 
 @State private var dragAmount = CGSize.zero
 
 var body: some View {
 LinearGradient(gradient: Gradient(colors: [.yellow,.red]), startPoint: .topLeading, endPoint: .bottomLeading)
 .frame(width: 200, height: 300)
 .clipShape(RoundedRectangle(cornerRadius: 10))
 .offset(dragAmount)
 .gesture(
 DragGesture()
 .onChanged {
 dragAmount = $0.translation
 }
 .onEnded {_ in
 withAnimation(.spring()) {
 dragAmount = .zero
 }
 }
 )
 
 
 }
 }
 */

//struct ContentView: View {
//
//    let letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count, id: \.self) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .foregroundColor(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(.default.delay(Double(num) / 10), value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged{ dragAmount = $0.translation}
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
//    }
//}

//struct ContentView: View {
//
//    @State private var isShowingRed = false
//
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200, alignment: .center)
//                    .transition(.asymmetric(insertion: .scale, removal: .scale))
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
