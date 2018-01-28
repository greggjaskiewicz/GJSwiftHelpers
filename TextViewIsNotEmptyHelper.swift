//
//  TextViewIsNotEmptyHelper.swift
//
//  Created by Gregg Jaskiewicz on 26/01/2018.
//  Copyright © 2018 Gregg Jaskiewicz. All rights reserved.
//

import Foundation
import UIKit

final class TextViewIsNotEmptyHelper: NSObject, UITextViewDelegate {

    private let minimalLength: Int
    private let notificationCallback: (_: Bool)->()

    init(minimalLength: Int = 1, notificationCallback: @escaping (_: Bool)->()) {
        self.minimalLength = minimalLength
        self.notificationCallback = notificationCallback
        super.init()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        guard let userEnteredString = textView.text as NSString? else {
            return true
        }

        let newString = userEnteredString.replacingCharacters(in: range, with: text) as NSString

        let qualifies = newString.length > self.minimalLength
        self.notificationCallback(qualifies)

        return true
    }
}
