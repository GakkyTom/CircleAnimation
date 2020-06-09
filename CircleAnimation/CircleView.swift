//
//  CircleView.swift
//  CircleAnimation
//
//  Created by tomoyaitagaki on 2020/06/09.
//  Copyright © 2020 eversense. All rights reserved.
//

import UIKit
class CircleView: UIView {
    // カスタムビューの中心を取得する変数 (UIViewのcenterプロパティだと親ビューの座標系で計算されてしまうため)
    private var boundsCenter: CGPoint { CGPoint(x: bounds.midX, y: bounds.midY) }

    // 角度を弧度に変換する
    private func degreeToRadian(_ d: CGFloat) -> CGFloat {
        return d * CGFloat.pi / 180
    }

    override func draw(_ rect: CGRect) {
        drawCircle(radius: rect.width / 2 - 40, lineWidth: 29, lineColor: UIColor.systemPink.cgColor, shapeEndDegree: 50)
        drawCircle(radius: rect.width / 2 - 70, lineWidth: 29, lineColor: UIColor.green.cgColor, shapeEndDegree: 140)
        drawCircle(radius: rect.width / 2 - 100, lineWidth: 29, lineColor: UIColor.blue.cgColor, shapeEndDegree: 75)
    }

    func drawCircle(radius: CGFloat, lineWidth: CGFloat, lineColor: CGColor, shapeEndDegree: CGFloat) {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.path = UIBezierPath(arcCenter: boundsCenter,
                                        radius: radius,
                                        startAngle: degreeToRadian(270),
                                        endAngle: degreeToRadian(shapeEndDegree),
                                        clockwise: true).cgPath
        circleLayer.strokeColor = lineColor
        circleLayer.fillColor = UIColor.clear.cgColor // これがないと円弧の内側が塗りつぶされる
        circleLayer.lineWidth = lineWidth
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)

        circleAnimation(circleLayer: circleLayer, fromValue: 0, toValue: 1, duration: 1)
    }

    // 円の描画アニメーション
    func circleAnimation(circleLayer: CAShapeLayer, fromValue: Int, toValue: Int, duration: Double) {
        let circleStrokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleStrokeAnimation.fromValue = fromValue
        circleStrokeAnimation.toValue = toValue
        circleStrokeAnimation.duration = duration
        // Ref) easingの調整
        // https://easings.net/ja#
        circleStrokeAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.16, 1, 0.3, 1)

        circleLayer.add(circleStrokeAnimation, forKey: nil)
    }
}
