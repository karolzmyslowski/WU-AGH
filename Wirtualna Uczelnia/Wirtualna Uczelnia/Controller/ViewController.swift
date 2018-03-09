//
//  ViewController.swift
//  Wirtualna Uczelnia
//
//  Created by Karol Zmyslowski on 30.01.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import WebKit
import TextFieldEffects
import SwiftSoup


class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var idTF :MadokaTextField!
    @IBOutlet weak var password: MadokaTextField!
    @IBOutlet weak var logInButton: UIButton!
   
    let webView = WKWebView()
    var marks:[Mark] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        password.isSecureTextEntry = true
        let url = URL(string: "https://dziekanat.agh.edu.pl")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
 

    @IBAction func touchUpInside(_ sender: Any) {
       
        let queue = DispatchQueue(label: "label")
        queue.sync {
            webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_MiddleContentPlaceHolder_txtIdent').value='\(self.idTF.text!)'", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_MiddleContentPlaceHolder_txtHaslo').value='\(self.password.text!)'", completionHandler: nil)
        }
        let deadlineTime = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_MiddleContentPlaceHolder_butLoguj').click();", completionHandler: nil)
        
        }
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        if webView.url == URL(string: "https://dziekanat.agh.edu.pl/KierunkiStudiow.aspx"){
            performSegue(withIdentifier: "select", sender: webView)
        } else if  webView.url == URL(string: "https://dziekanat.agh.edu.pl/Ogloszenia.aspx"){
            
            let serialQueue = DispatchQueue(label: "queuename")
            serialQueue.sync {
                
            let url = URL(string: "https://dziekanat.agh.edu.pl/OcenyP.aspx")
            let request = URLRequest(url: url!)
            self.webView.load(request)
            if webView.url == URL(string: "https://dziekanat.agh.edu.pl/OcenyP.aspx"){
                
                
                    
                    webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                               completionHandler: { (html: Any?, error: Error?) in
                                                let htt = String(describing: html)
                                                do {
                                                    let doc: Document = try! SwiftSoup.parse(htt)
                                                    let table = try doc.getElementsByClass("gridDane").array()
                                                    for i in table {
                                                        let x = try i.select("td").array()
                                                        // nazwa przedmiotu
                                                        let sub: String = try x[0].text()
                                                        // forma zajec
                                                        let form: String = try x[2].text()
                                                        // ocena z przedmiotu końcowa
                                                        let score = try x[3].text()
                                                        // pierwszy termin
                                                        let term1 = try x[4].text()
                                                        let term2 = try x[5].text()
                                                        let term3 = try x[6].text()
                                                        let m = Mark(subject: sub, score: score, term1: term1, term2: term2, term3: term3, form: form)
                                                        print(m.score)
                                                        print(m.subject)
                                                        self.marks.append(m)
                                                    }
                                                    
                                                } catch {
                                                    print("nie")
                                                    
                                                }
                                                self.performSegue(withIdentifier: "show", sender: self.marks)
                    })
                }
                
            }
            
        } else if  webView.url == URL(string: "https://dziekanat.agh.edu.pl/"){
            logInButton.isEnabled = true
            logInButton.setTitle("Zaloguj", for: .normal)
            
        }
    } 
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select"{
            let viewController = segue.destination as! SelectVC
            viewController.webView = self.webView
        }
    }
}

