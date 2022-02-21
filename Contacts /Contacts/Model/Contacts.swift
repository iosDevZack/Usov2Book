//
//  Contacts.swift
//  Contacts
//
//  Created by Женя  on 21.02.22.
//

import Foundation

protocol ContactProtocol {
    
    //Имя
    var title: String { get set }
    
    // Номер телефона
    var phone: String { get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
