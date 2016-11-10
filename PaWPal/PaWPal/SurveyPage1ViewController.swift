//
//  SurveyPage1ViewController.swift
//  PaWPal
//
//  Created by Tiffany Fong on 9/27/16.
//  Copyright © 2016 HMC CS121 Group 5. All rights reserved.
//

import UIKit

class SurveyPage1ViewController: UIViewController, AutoCompleteTextFieldDataSource, AutoCompleteTextFieldDelegate {
    var q1: TextQuestion!
    var q2: TextQuestion!
    var q3: TextQuestion!
    var locations: [String] = ["Platt", "Place", "Shanahan", "Atwood"]
    var activities: [String] = ["Working", "Class"]
    
    @IBAction func next(sender: UIButton) {
        // require that text fields be complete
        guard let textAnswer1 = q1.answerTextField.text
            where !textAnswer1.isEmpty else {
                self.displayAlert("Hello", message: "Please fill in all required fields :)", handler: nil)
                return
        }
        guard let textAnswer2 = q2.answerTextField.text
            where !textAnswer2.isEmpty else {
                self.displayAlert("Hello", message: "Please fill in all required fields :)", handler: nil)
                return
        }
        DatabaseController.updateText("where", question: q1)
        DatabaseController.updateText("activity", question: q2)
        DatabaseController.updateText("elseOptional", question: q3)
    }
    
    func displayQuestions(){
        
        // create the stack view
        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // add questions to the stack view
        q1 = TextQuestion.addToSurvey("Where were you?", key: "where", stackView: stackView, placeHolder: "Platt, Shanahan, Atwood, etc. ")
        q2 = TextQuestion.addToSurvey("What was the main thing you were doing?", key: "activity", stackView: stackView, placeHolder: "Working, Class, etc. ")
        q3 = TextQuestion.addToSurvey("(Optional) What else were you doing?", key: "elseOptional", stackView: stackView, placeHolder: "")
        
        view.addSubview(stackView)
        
        //autolayout the stack view - pin 30 up 20 left 20 right 100 down
        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[stackView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[stackView]-100-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestions()
        q1.answerTextField.autoCompleteTextFieldDataSource = self
        q1.answerTextField.showAutoCompleteButton(autoCompleteButtonViewMode: .WhileEditing)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationTextFieldChanged(textField: UITextField) {
        //go through list and compare to textfield
        var list = locations
        var textFieldLength: Int { return (textField.text?.characters.count)! }
        if (textFieldLength > 0 && list.count > 0)
        {
            var startIndex = list[0].startIndex
            var endIndex = list[0].startIndex.advancedBy(textFieldLength-1)
            var subStrFromList = list[0][startIndex...endIndex]
            for i in 0...(list.count-1){
                startIndex = list[i].startIndex
                endIndex = list[i].startIndex.advancedBy(textFieldLength-1)
                subStrFromList = list[i][startIndex...endIndex]
                if(textField.text?.lowercaseString == subStrFromList.lowercaseString){
                    print(list[i])
                }
            }
        }
    }
    
    func autoCompleteTextFieldDataSource(autoCompleteTextField: AutoCompleteTextField) -> [String] {
        
        return ["example", "pawpal", "hello"]
    }
}