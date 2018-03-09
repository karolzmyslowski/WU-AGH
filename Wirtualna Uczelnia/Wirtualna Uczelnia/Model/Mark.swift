//
//  Mark.swift
//  Wirtualna Uczelnia
//
//  Created by Karol Zmyslowski on 21.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import Foundation


class Mark {
    
    
    var subject: String
    var score: String
    var form: String
    var term1: String
    var term3: String
    var term2: String
    
    init(subject: String, score: String, term1:String, term2: String, term3: String, form: String) {
        self.score = score
        self.subject = subject
        self.form = form
        self.term1 = term1
        self.term2 = term2
        self.term3 = term3
    }
    
    
}
