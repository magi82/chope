//
// Created by Chope on 2017. 1. 16..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import UIKit

struct KeyboardEvent {
    let beginFrame: CGRect
    let endFrame: CGRect
    let duration: Double
    let animationOptions: UIViewAnimationOptions
}

extension Dictionary {
    func keyboardInfo() -> KeyboardEvent {
        guard let beginFrameKey = UIKeyboardFrameBeginUserInfoKey as? Key,
              let endFrameKey = UIKeyboardFrameEndUserInfoKey as? Key,
              let durationKey = UIKeyboardAnimationDurationUserInfoKey as? Key,
              let animationOptionsKey = UIKeyboardAnimationCurveUserInfoKey as? Key,
              let beginFrameValue = self[beginFrameKey] as? NSValue,
              let endFrameValue = self[endFrameKey] as? NSValue,
              let durationValue = self[durationKey] as? NSNumber,
              let animationOptionsValue = self[animationOptionsKey] as? NSNumber else {
            return KeyboardEvent(beginFrame: .zero, endFrame: .zero, duration: 0, animationOptions: UIViewAnimationOptions())
        }
        let beginFrame = beginFrameValue.cgRectValue
        let endFrame = endFrameValue.cgRectValue
        let duration = durationValue.doubleValue
        let animationOptions = UIViewAnimationOptions(rawValue: animationOptionsValue.uintValue << 16)
        return KeyboardEvent(beginFrame: beginFrame, endFrame: endFrame, duration: duration, animationOptions: animationOptions)
    }
}