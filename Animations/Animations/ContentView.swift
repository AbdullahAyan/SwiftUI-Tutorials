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

/* MARK: - Animating with withAnimation()
struct ContentView: View {

    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}
 */
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
     */
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
