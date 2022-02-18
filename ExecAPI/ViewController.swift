//
//  ViewController.swift
//  ExecAPI
//
//  Created by たうんりばー on 2022/02/18.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK: - Constants
    var authToken:String = ""
    
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
    
    struct AuthRes: Codable {
        var access_token: String
    }

    //MARK: - IBActions
    @IBAction func execBtnPressed(_ sender: Any) {
        if clientIdTextField.text == "" {
            resultViewTextField.text = "ClientIDを入力してください"
        } else if clientSecretTextField.text == "" {
            resultViewTextField.text = "ClientSecretを入力してください"
        } else if authURLTextFields.text == "" {
            resultViewTextField.text = "authURLを入力してください"
        }else if restURLTextField.text == "" {
            resultViewTextField.text = "restURLを入力してください"
        }else if midTextField.text == "" {
            resultViewTextField.text = "MIDを入力してください"
        }else if messageIDTextField.text == "" {
            resultViewTextField.text = "Push Triggesend の MessageIDを入力してください"
    // OK
        } else {
            resultViewTextField.text = "OK"
            getAuthRequest()
            execMessagingAPI()
        }
    }
    
    // 認証の処理
    private func getAuthRequest () {
        // トークンげっと
        var authUrl = URL(string: "https://ひみつ/v2/token")!
        // リクエストボディの整形
        var data: [String: Any] = ["grant_type": "client_credentials",
                                   "client_id":"ひみつ",
                                   "client_secret":"ひみつ",
                                   "account_id":"ひみつ"]
        var request = URLRequest(url: authUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        // データがレスポンスボディ、responseはヘッダーメイン
        URLSession.shared.dataTask(with: request) { [self](data, response, error) in
            // HTTP以前の、実行エラー時の処理
            if let error = error {
                print("Failed to get item info: \(error)")
                self.resultViewTextField.text = "HTTPリクエストの実行中に何らかのエラーが発生しました"
                return;
            }
            // HTTPは通るが、ステータスが400や500番台のときの処理
            if let response = response as? HTTPURLResponse {
                // HTTP 200番台以外が帰ってきたときの処理
                if !(200...299).contains(response.statusCode) {
                    print("Response status code does not indicate success: \(response.statusCode)")
                    // メインスレッド以外でUIの更新はできないため、この書き方になる。
                    DispatchQueue.main.async {
                        resultViewTextField.text =  "ステータスコード： \(response.statusCode)  ClientID/Secret等、なにか間違えてます。"
                    }
                }
            }
            // データのツッコミ処理
            if let data = data {
                do {
                    // レスポンスボディを辞書型にキャスト
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if(true) {
                        self.authToken = jsonDict!["access_token"] as! String
                    }
                } catch {
                    print("何らかのエラーが出ています。")
                }
            } else {
                print("Unexpected error.")
            }
        }.resume()
    }
    
    private func execMessagingAPI() {
        // REST URL えんどぽいんと
        var restUrl = URL(string: "https://ひみつ/push/v1/messageApp/MTAzOjExNDow/send")!
        // リクエストボディの整形
        var data: [String: Any] = ["InclusionListIds": ["5eaf68e3-246d-ec11-ba28-d4f5ef3de415"]]
        var request = URLRequest(url: restUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.authToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        // データがレスポンスボディ、responseはヘッダーメイン
        URLSession.shared.dataTask(with: request) { [self](data, response, error) in
            // HTTP以前の、実行エラー時の処理
            if let error = error {
                print("Failed to get item info: \(error)")
                self.resultViewTextField.text = "HTTPリクエストの実行中に何らかのエラーが発生しました"
                return;
            }
            // HTTPは通るが、ステータスが400や500番台のときの処理
            if let response = response as? HTTPURLResponse {
                // HTTP 200番台以外が帰ってきたときの処理
                if !(200...299).contains(response.statusCode) {
                    print("Response status code does not indicate success: \(response.statusCode)")
                    // メインスレッド以外でUIの更新はできないため、この書き方になる。
                    DispatchQueue.main.async {
                        resultViewTextField.text =  "ステータスコード： \(response.statusCode)  Message, ListID等、なにか間違えてます。"
                    }
                }
            }
            // データのツッコミ処理
            if let data = data {
                do {
                    // レスポンスボディを辞書型にキャスト
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if(true) {
//                        self.authToken = jsonDict!["access_token"] as! String
                        // メインスレッド以外でUIの更新はできないため、この書き方になる。
                        DispatchQueue.main.async {
                            resultViewTextField.text =  "成功しました"
                        }

                    }
                } catch {
                    print("何らかのエラーが出ています。")
                }
            } else {
                print("Unexpected error.")
            }
        }.resume()

    }

    

}

