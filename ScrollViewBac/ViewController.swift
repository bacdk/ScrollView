//
//  ViewController.swift
//  ScrollViewBac
//
//  Created by miceli on 5/5/17.
//  Copyright © 2017 zwart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardDidShow), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    func textFieldDidEndEditing(textField: UITextField) {
        self.textField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField = textField
    }    //
    func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.textField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!aRect.contains(activeField.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    func tap(gesture: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
}

