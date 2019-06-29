//
//  ViewController.swift
//  Week3Assignment
//
//  Created by iching chen on 2019/6/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//
//  week3 assignment
//  Log-in and sign-up page demo

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!
    @IBOutlet weak var checkLabel: UILabel!
    
    private var currentSegmentStatus: SegmentStatus = .logIn // log in or sing up status
    let menbership = Membership()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    // 監控segmentedControl 0: log in 1: sign up
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // login
            currentSegmentStatus = .logIn
            changeCheckState(isDisable: true)
        } else {
            // sign up
            currentSegmentStatus = .singUp
            changeCheckState(isDisable: false)
        }
    }
    
    // change checkLabel status
    func changeCheckState(isDisable: Bool) {
        func set(_ labelTextColor: UIColor, _ textFieldBGColor: UIColor,_ isEnabled: Bool) {
            checkLabel.textColor = labelTextColor
            checkTextField.backgroundColor = textFieldBGColor
            checkTextField.isEnabled = isEnabled
        }
        if isDisable == true {
            checkTextField.text = nil // clean text in textField
            set(UIColor.gray, UIColor.gray, false)
        } else {
            set(UIColor.black, UIColor.white, true)
        }
        
    }
    
    @IBAction func Commit(_ sender: Any) { // press Button
        do{
            // check if textField data is valid
            let alertData = try menbership.membershipDataCheck(account: accountTextField.text, password: passwordTextField.text, checkPassword: checkTextField.text, currentSegmentStatus: currentSegmentStatus)
            
            showAlert(title: "Success" , message: alertData)
            
        } catch ErrorMessage.emptyAccount {
            showAlert(message: "Account shoud not be empty.")
        } catch ErrorMessage.emptyPassword {
            showAlert(message: "Password should not be empty.")
        } catch ErrorMessage.emptyCheckPasseord {
            showAlert(message: "Check password should not be empty.")
        } catch ErrorMessage.LoginFail {
            showAlert(message: "Log in fail, Check your account and password is correct.")
        } catch ErrorMessage.signupFail {
            showAlert(message: "Sign up fail, Check password shold same as password.")
        } catch let error {
           fatalError("\(error)")
        }
    }
    
    
    func showAlert(title: String = "Error", message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: dismissAlert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func dismissAlert(sender: UIAlertAction) -> Void {
        
    }
}



