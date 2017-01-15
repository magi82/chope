//
// Created by Chope on 2017. 1. 16..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    func keyboardInfo() -> (beginFrame: CGRect, endFrame: CGRect, duration: Double, animationOptions: UIViewAnimationOptions) {
        guard let beginFrameKey = UIKeyboardFrameBeginUserInfoKey as? Key,
              let endFrameKey = UIKeyboardFrameEndUserInfoKey as? Key,
              let durationKey = UIKeyboardAnimationDurationUserInfoKey as? Key,
              let animationOptionsKey = UIKeyboardAnimationCurveUserInfoKey as? Key,
              let beginFrameValue = self[beginFrameKey] as? NSValue,
              let endFrameValue = self[endFrameKey] as? NSValue,
              let durationValue = self[durationKey] as? NSNumber,
              let animationOptionsValue = self[animationOptionsKey] as? NSNumber else {
            return (CGRect.zero, CGRect.zero, 0.0, UIViewAnimationOptions())
        }
        let beginFrame = beginFrameValue.cgRectValue
        let endFrame = endFrameValue.cgRectValue
        let duration = durationValue.doubleValue
        let animationOptions = UIViewAnimationOptions(rawValue: animationOptionsValue.uintValue << 16)
        return (beginFrame, endFrame, duration, animationOptions)
    }
}