//
//  File.swift
//  hiracaneUI
//
//  Created by Hirakjyoti Borah on 10/10/24.
//

import SwiftUI

public struct CircularProgressModel {
    public let strokeWidth: CGFloat
    public let progressColor: Color
    public let backgroundColor: Color
    public var startValue: Double = 0
    public var endValue: Double = 1
    public var shouldAnimate: Bool = false

    public init(strokeWidth: CGFloat, progressColor: Color, backgroundColor: Color, startValue: Double, endValue: Double, shouldAnimate: Bool) {
        self.strokeWidth = strokeWidth
        self.progressColor = progressColor
        self.backgroundColor = backgroundColor
        self.startValue = startValue
        self.endValue = endValue
        self.shouldAnimate = shouldAnimate
    }
}

public struct CircularProgressBar: View {

    @State private var animatedEndValue: Double = 0

    private let model: CircularProgressModel

    public init(model: CircularProgressModel) {
        self.model = model
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(
                    model.backgroundColor,
                    style: StrokeStyle(lineWidth: model.strokeWidth, lineCap: .round))
            Circle()
                .trim(from: model.startValue, to: model.endValue)
                .stroke(
                    model.progressColor,
                    style: StrokeStyle(lineWidth: model.strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(model.shouldAnimate ? .linear(duration: 1.0) : .none, value: animatedEndValue)
        }
        .onAppear {
            if model.shouldAnimate {
                animatedEndValue = model.endValue
            } else {
                animatedEndValue = model.startValue
            }
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 300)
    }
}


#Preview {
    CircularProgressBar(
        model: CircularProgressModel(
            strokeWidth: 20,
            progressColor: Color.red,
            backgroundColor: Color.pink.opacity(0.5),
            startValue: 0,
            endValue: 0.75,
            shouldAnimate: true
        )
    )
}
