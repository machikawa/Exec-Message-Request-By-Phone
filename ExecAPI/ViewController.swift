//
//  ViewController.swift
//  ExecAPI
//
//  Created by たうんりばー on 2022/02/18.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var clientIdTextField: UITextField!
    @IBOutlet weak var clientSecretTextField: UITextField!
    @IBOutlet weak var authURLTextFields: UITextField!
    @IBOutlet weak var restURLTextField: UITextField!
    @IBOutlet weak var midTextField: UITextField!
    @IBOutlet weak var resultViewTextField: UITextField!
    @IBOutlet weak var messageIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - IBActions
    @IBAction func execBtnPressed(_ sender: Any) {
        if clientIdTextField.text == "" ||
            clientSecretTextField.text == "" ||
            authURLTextFields.text == "" ||
            restURLTextField.text == "" ||
            midTextField.text == "" ||
            messageIDTextField.text == ""
        // 入力規則 NG
        {
            resultViewTextField.text = "全項目を入力しないと実行できません"
            return
        // 入力OK
        } else {
            resultViewTextField.text = "OK"
        }
    }
    
    private func executeAPIRequest () {
        
    }
    
    // 削除必須REST
    //
    private func dammygetURL () {
        
    }
    
    private func getURL () {
        
    }

}

