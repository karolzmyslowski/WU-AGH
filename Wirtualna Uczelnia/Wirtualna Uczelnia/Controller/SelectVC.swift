//
//  SelectVC.swift
//  Wirtualna Uczelnia
//
//  Created by Karol Zmyslowski on 31.01.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup

class SelectVC: UIViewController, WKNavigationDelegate {
    
    
    
    @IBOutlet weak var firstFieldOfStudy: UILabel!
    @IBOutlet weak var secendFieldOfStudy: UILabel!
    @IBOutlet weak var topCheckmark: UIButton!
    @IBOutlet weak var botCheckmark: UIButton!
    
    
    var poop = 0
    var marks:[Mark] = []
    var webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        choiceFieldStudy()
    }
    
    @IBAction func pierwszy(_ sender: Any) {
        webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_RightContentPlaceHolder_rbKierunki_0').click();", completionHandler: nil)
            topCheckmark.alpha = 1
            botCheckmark.alpha = 0.4
    }
    
    @IBAction func secend(_ sender: Any) {
        webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_RightContentPlaceHolder_rbKierunki_1').click();", completionHandler: nil)
        topCheckmark.alpha = 0.4
        botCheckmark.alpha = 1
    }
    @IBAction func selectstSpecialization(_ sender: UIButton) {
       
        
        let serialQueue = DispatchQueue(label: "queuename")
        serialQueue.sync {
        webView.evaluateJavaScript("document.getElementById('ctl00_ctl00_ContentPlaceHolder_RightContentPlaceHolder_Button1').click();", completionHandler: nil)
          
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            let url = URL(string: "https://dziekanat.agh.edu.pl/OcenyP.aspx")
            let request = URLRequest(url: url!)
            self.webView.load(request)
                }
            )
        }
  
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectDone"{
            let viewController = segue.destination as! MarkVC
            viewController.marks = self.marks
        }
    }
    @IBAction func takeMark(_ sender: Any) {
        if poop == 1 {
            }
        }
    
    func choiceFieldStudy(){
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
                                    let htt = String(describing: html)
                                    do {
                                        let doc: Document = try! SwiftSoup.parse(htt)
                                        let table = try doc.select("label").array()
                                        self.firstFieldOfStudy.text = try table[0].text()
                                        self.secendFieldOfStudy.text = try table[1].text()
    
                                    } catch {
                                        print("Error no.2")
                                    }
        })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        if webView.url == URL(string: "https://dziekanat.agh.edu.pl/OcenyP.aspx"){
           
            let serialQueue = DispatchQueue(label: "queuename")
            serialQueue.sync {
                
                
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
                                self.performSegue(withIdentifier: "selectDone", sender: self.marks)
                })
                
                
                
            }
       
        }
    }

    
}

