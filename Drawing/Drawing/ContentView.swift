//
//  ContentView.swift
//  Drawing
//
//  Created by Abdullah Ayan on 24.08.2022.
//

import SwiftUI


struct ContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
                
                
            }
            .drawingGroup()
            Slider(value: $colorCycle)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
    
    
    
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        while targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arc: InsettableShape {
    
    var rotationAdjustment: Angle = .degrees(90)
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: (rect.width / 2) - insetAmount, startAngle: startAngle - rotationAdjustment, endAngle: endAngle - rotationAdjustment, clockwise: !clockWise)
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: (rect.width / 2) - insetAmount, startAngle: startAngle - rotationAdjustment, endAngle: endAngle - rotationAdjustment, clockwise: clockWise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    
}

struct Flower: Shape {
    
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 4) {
            
            let rotation = CGAffineTransform(rotationAngle: number)
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let petal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = petal.applying(position)
            
            path.addPath(rotatedPetal)
            
        }
        return path
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

