//
//  TextFieldIsNotEmptyHelper.swift
//
//  Created by Gregg Jaskiewicz on 26/01/2018.
//  Copyright © 2018 Gregg Jaskiewicz. All rights reserved.
//

import Foundation
import UIKit

final class TextFieldIsNotEmptyHelper: NSObject, UITextFieldDelegate {

    private let minimalLength: Int
    private let notificationCallback: (_: Bool)->()

    init(minimalLength: Int = 1, notificationCallback: @escaping (_: Bool)->()) {
        self.minimalLength = minimalLength
        self.notificationCallback = notificationCallback
        super.init()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let userEnteredString = textField.text as NSString? else {
            return true
        }

        let newString = userEnteredString.replacingCharacters(in: range, with: string) as NSString

        let qualifies = newString.length > self.minimalLength
        self.notificationCallback(qualifies)

        return true
    }
}
