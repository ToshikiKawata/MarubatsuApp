//
//  CreateViewController.swift
//  MarubatsuApp
//
//  Created by 川田俊希 on 2021/11/08.
//

import UIKit


class CreateViewController: UIViewController {
    
    var questions: [[String: Any]] = []
    //戻るボタン
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //○ or ✗
    @IBOutlet weak var YesOrNo: UISegmentedControl!
    
    //投稿ボタン
    @IBAction func SaveButton(_ sender: Any) {
        
        //テキストフィールドとまるばつから情報を取得して問題の配列に格納する
        
        if Text.text != "" {
        
            var answer: Bool = true
        
            if YesOrNo.selectedSegmentIndex == 0 {
                answer = false
            } else {
                answer = true
            }
            
            let userDefaults = UserDefaults.standard //そのままだと長いので変数にいれる
            questions = []
            
            //"add"というキーで保存された値がなにかある -> 値をtaskArrayへ
            if userDefaults.object(forKey: "add") != nil {
                questions = userDefaults.object(forKey: "add") as! [[String: Any]]
            }

            questions.append(["question": Text.text!, "answer": answer])
            alert(message: "問題が保存されました")
            
            userDefaults.set(questions, forKey: "add") //キー"add"で配列をUserDefaultsに保存
            print(questions)
            Text.text = ""
            
        } else {
             alert(message: "問題が未入力です")
             }
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        //入っている配列をカラにする
        let userDefaults = UserDefaults.standard
        questions = []
        userDefaults.set(questions, forKey: "add")
        alert(message: "問題を全て削除しました")
    }
        
    @IBOutlet weak var Text: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func alert(message: String) {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
            alertController.addAction(close)
            present(alertController, animated: true, completion: nil)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
