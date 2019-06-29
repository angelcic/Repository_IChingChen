//
//  Member.swift
//  Week3Assignment
//
//  Created by iching chen on 2019/6/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class Membership {
    
    func membershipDataCheck(account: String?, password: String?, checkPassword: String? = nil, currentSegmentStatus: SegmentStatus) throws -> String {
        guard let account = account, account.count != 0 else {
            throw ErrorMessage.emptyAccount
        }
        guard let password = password, password.count != 0 else {
            throw ErrorMessage.emptyPassword
        }
        if currentSegmentStatus == .logIn { //log in check
            if account.elementsEqual("appwork_school@gmail.com") &&  password.elementsEqual("1234") {
                return "Log in success"
            } else {
                throw ErrorMessage.LoginFail
            }
        } else { // sign up check
            guard let checkPassword = checkPassword, checkPassword.count != 0 else {
                throw ErrorMessage.emptyCheckPasseord
            }
            if checkPassword.elementsEqual(password) {
                return "Sign up success"
            } else {
                throw ErrorMessage.signupFail
            }
        }
    }
}

enum SegmentStatus {
    case logIn
    case singUp
}

enum ErrorMessage: Error {
    case emptyAccount
    case emptyPassword
    case emptyCheckPasseord
    case signupFail
    case LoginFail
}
