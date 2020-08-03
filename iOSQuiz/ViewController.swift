//
//  ViewController.swift
//  iOSQuiz
//
//  Created by BALA SEKHAR on 02/08/20.
//  Copyright © 2020 BALU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Constants
    let questions=[Question(question: "How many windows are there for an iOS app?", image:#imageLiteral(resourceName: "images-content-how-to-new-How+to+clear+Xcode+cache+and+stop+crashes+G+1200x670"), answer1: "1", answer2: "2", answer3: "3", answer4: "4", correctAnswer: 1),
                   Question(question: "Core Data is a?", image: #imageLiteral(resourceName: "images-content-how-to-new-How+to+clear+Xcode+cache+and+stop+crashes+G+1200x670"), answer1: "Database", answer2: "Dispatch Groups", answer3: "Librarie", answer4: "Framework", correctAnswer: 4),
    Question(question: "SuperClass of UIViewController", image:#imageLiteral(resourceName: "images-content-how-to-new-How+to+clear+Xcode+cache+and+stop+crashes+G+1200x670"), answer1: "UIResponder", answer2: "UIView", answer3: "UIControl", answer4: "UIWindow", correctAnswer: 1),
    Question(question: "SuperClass of UIWindow?", image: #imageLiteral(resourceName: "images-content-how-to-new-How+to+clear+Xcode+cache+and+stop+crashes+G+1200x670"), answer1: "UIResponder", answer2: "UIWindow", answer3: "UIControl", answer4: "UIView", correctAnswer: 4)]
    //Variables
    var buttonsArray=[UIButton]()
    var index=0
    var score=0
    //MARK: - IBOutlets

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var answerBUtton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var nextButtonIB: UIButton!
    
    

    
    
    //MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
       buttonsArray=[answerBUtton1,answerButton2,answerButton3,answerButton4]
        generateQuestion(number: index)
        //Set tag for each button
        answerBUtton1.tag=1
        answerButton2.tag=2
        answerButton3.tag=3
        answerButton4.tag=4
    }

    

    //MARK: - IBActions
    
    @IBAction func answerButton1Tapped(_ sender: UIButton) {
        revealAnswer()
        selectedButton(button: answerBUtton1)
        disableButton(buttons: buttonsArray)
        checkAnswer(button: answerBUtton1)
    }
    
    @IBAction func answerButton2Tapped(_ sender: UIButton) {
        revealAnswer()
        selectedButton(button: answerButton2)
        disableButton(buttons: buttonsArray)
        checkAnswer(button: answerButton2)
    }
    
    @IBAction func answerButton3Tapped(_ sender: UIButton) {
        revealAnswer()
        selectedButton(button: answerButton3)
        disableButton(buttons: buttonsArray)
        checkAnswer(button: answerButton3)
    }
    
    @IBAction func answerButton4Tapped(_ sender: UIButton) {
        revealAnswer()
        selectedButton(button: answerButton4)
        disableButton(buttons: buttonsArray)
        checkAnswer(button: answerButton4)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if index == questions.endIndex - 1 {
            print("Score:\(score)")
            showScore()
        }else{
            index += 1
            generateQuestion(number: index)
            resetButtons(buttons: buttonsArray)
            if index == questions.endIndex - 1{
                nextButtonIB.setTitle("Next", for: .normal)
            }
        }
        
    }
    //MARK: - Fileprivate Methods
    fileprivate func showScore(){
        let scoreAlart=UIAlertController(title: "Score:\(score)", message: "You have scored🥳:\(score)", preferredStyle: .alert)
        scoreAlart.addAction(UIAlertAction(title: "Restart", style: .default, handler: { ( _ ) in
            self.score=0
            self.index=0
            self.generateQuestion(number: self.index)
            self.nextButtonIB.setTitle("Next", for: .normal)
            self.resetButtons(buttons: self.buttonsArray)
        }))
        present(scoreAlart, animated: true)
    }
    fileprivate func generateQuestion(number:Int){
        questionLabel.text=questions[number].question
        questionImage.image=questions[number].image
        
        answerBUtton1.setTitle(questions[number].answer1, for: .normal)
        answerButton2.setTitle(questions[number].answer2, for: .normal)
        answerButton3.setTitle(questions[number].answer3, for: .normal)
        answerButton4.setTitle(questions[number].answer4, for: .normal)
    }
    fileprivate func revealAnswer(){
        switch questions[index].correctAnswer {
        case 1:
            changeButtonState(correctButton: answerBUtton1, incorrectButtons: [answerButton2,answerButton3,answerButton4])
        case 2:changeButtonState(correctButton: answerButton4, incorrectButtons: [answerBUtton1,answerButton2,answerButton3])
        case 3:
                changeButtonState(correctButton: answerBUtton1, incorrectButtons: [answerButton2,answerButton3,answerButton4])
        case 4:changeButtonState(correctButton: answerButton4, incorrectButtons: [answerBUtton1,answerButton2,answerButton3])
        default:
            break
        }
    }
    fileprivate func changeButtonState(correctButton:UIButton,incorrectButtons:[UIButton]){
        correctButton.backgroundColor = .green
        for button in incorrectButtons{
            button.backgroundColor = .red
        }
    }
    fileprivate func selectedButton(button:UIButton){
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth=2
    }
    fileprivate func disableButton(buttons:[UIButton]){
        for button in buttons{
            button.isUserInteractionEnabled=false
        }
    }
    fileprivate func resetButtons(buttons:[UIButton]){
        for button in buttons{
            button.isUserInteractionEnabled=true
            button.layer.backgroundColor=UIColor.clear.cgColor
            button.backgroundColor = .none
        }
    }
    fileprivate func checkAnswer(button:UIButton){
        if button.tag == questions[index].correctAnswer{
            score += 1
        }
        print(score)
    }
}

