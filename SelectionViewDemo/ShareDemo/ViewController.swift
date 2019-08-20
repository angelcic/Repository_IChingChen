//
//  ViewController.swift
//  ShareDemo
//
//  Created by iching chen on 2019/8/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteTextView()
//        alertAction()
    }
    
    func configureNoteTextView() {
        noteTextView.layer.cornerRadius = 8.0
        noteTextView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).cgColor
        noteTextView.layer.borderWidth = 1.2
    }
    
    @IBAction func showShareOptions(_ sender: Any) {
//        alertAction()
//        defaultAction()
        let url = URL(string: "https://www.appcoda.com.tw/social-framework-introduction/")
        let actView:UIActivityViewController =
            UIActivityViewController(activityItems: [url], applicationActivities: nil)
        //要排除的分享按钮，不显示在分享框里
//        actView.excludedActivityTypes = [.mail,.copyToPasteboard,.print,
//                                         .assignToContact,.saveToCameraRoll]
        //显示分享视图
        self.present(actView, animated:true, completion:nil)
    }
    
    func alertAction() {
        
        let moreAction = UIAlertAction(title: "More", style: UIAlertAction.Style.default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: [self.noteTextView.text], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [UIActivity.ActivityType.mail]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
    func defaultAction() {
        if noteTextView.isFirstResponder {
            noteTextView.resignFirstResponder
        }
        
        let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 設定分享至 Facebook 的新動作
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertAction.Style.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                guard let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook) else { return }
                
                facebookComposeVC.setInitialText("\(self.noteTextView.text)")
                
                self.present(facebookComposeVC, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not connected to your Facebook account.")
            }
        }
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(dismissAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

