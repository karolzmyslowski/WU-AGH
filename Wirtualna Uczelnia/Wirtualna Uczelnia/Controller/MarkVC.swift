//
//  MarkVC.swift
//  Wirtualna Uczelnia
//
//  Created by Karol Zmyslowski on 30.01.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class MarkVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var marks: [Mark]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension MarkVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "markCell") as! MarkCell
        let mark = marks[indexPath.row]
        cell.markLbn.text = mark.score
        cell.subjectLbn.text = mark.subject
        cell.formLbn.text = mark.form
        cell.term1.text = mark.term1
        cell.term2.text = mark.term2
        cell.term3.text = mark.term3
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension MarkVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }}
