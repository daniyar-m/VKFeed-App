//
//  Message.swift
//  temp-mail
//
//  Created by Daniyar Mamadov on 09.02.2023.
//

import Foundation

struct Message {
    let timestamp: Date
    let sender: String
    let title: String
    let body: String
    
    func getDummyData() -> [Message] {
        let data: [Message] = [Message(timestamp: Date.distantPast, sender: "Dan", title: "Hello", body: "Heelo world"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "How r u?", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "u good", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "testing", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "another test", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "QWERTY", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "1234565678987654323456", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "Long title: qwertyui opasdfg hjkl zx cvbnm,", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "long body", body: "A timestamp is that which is not readable form when you get it from the server or from other sources. So while to show some event, date or time in your application you have to make a timestamp into the readable form, you can make it readable form using these objects Date, Calendar, DateFormatter and use many more."),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "BYE!", body: "test")]
        return data
    }
}
