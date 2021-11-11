//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by 川田俊希 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    var questions: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        showQuestion()
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    func showQuestion() {
        if questions.isEmpty == true {
            questionLabel.text = "問題がありません。問題文を作りましょう。"
        } else {
            var question = questions[currentQuestionNum]
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }
    }
    
    func checkAnswer(yourAnswer: Bool) {
        
        let question = questions[currentQuestionNum]
        if questions.isEmpty != true {
            if let ans = question["answer"] as? Bool {
                if yourAnswer == ans {
                    // 正解
                    // currentQuestionNumを1足して次の問題に進む
                    currentQuestionNum += 1
                    showAlert(message: "正解！")
                } else {
                    // 不正解
                    showAlert(message: "不正解…")
                }
            } else {
                print("答えが入っていません")
                return
            }
            // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
            if currentQuestionNum >= questions.count {
                currentQuestionNum = 0
            }
            // 問題を表示します。
            // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
            showQuestion()
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}

