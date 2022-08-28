//
//  ContentView.swift
//  Drawing
//
//  Created by Abdullah Ayan on 24.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmout = 30.0
    @State private var supx: CGFloat = 0.0
    @State private var supy: CGFloat = 0.0
    @State private var eupx: CGFloat = 0.0
    @State private var eupy: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(supx: supx, supy: supy, eupx: eupx, eupy: eupy)
                .drawingGroup()

            Slider(value: $supx, in: 0.0...1.0)
            Slider(value: $supy, in: 0.0...1.0)
            Slider(value: $eupx, in: 0.0...1.0)
            Slider(value: $eupy, in: 0.0...1.0)

        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var supx: CGFloat
    var supy: CGFloat
    var eupx: CGFloat
    var eupy: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: supx, y: supy),
                            endPoint: UnitPoint(x: eupx, y: eupy)
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

struct Arrow: Shape {
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.midY))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        
        path.closeSubpath()
        
        return path
    }
    
    
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
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

struct Trapezoid: Shape {
    var insetAmount: Double
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.midY))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        
        path.closeSubpath()
        
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

