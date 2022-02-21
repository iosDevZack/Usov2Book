//
//  ViewController.swift
//  Contacts
//
//  Created by Женя  on 21.02.22.
// Page 139- 168

import UIKit

class ViewController: UIViewController {
    
    //MARK: - property
    
    private var contacts = [ContactProtocol]()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
        
    }
    
    //MARK: - Logic
    
    private func loadContacts() {
        contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
        contacts.append(Contact(title: "Сильвестр", phone: "+7000911112"))
        contacts.sort{ $0.title < $1.title}
    }


}

//MARK: - Extenssion TableView

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // производим попытку загрузки переиспользуемой ячейки
//        guard var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {
//            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
//
//            // получаем экземпляр ячейки
//            var newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
//
//            configure(cell: &newCell, for: indexPath)
//            return newCell
//
//            // конфигурируем ячейку
////            var configuration = newCell.defaultContentConfiguration()
////            configuration.text = "Строка \(indexPath.row)"
////            newCell.contentConfiguration = configuration
////            return newCell
//        }
//
//        print("Используем старую ячейку для строки с индеком \(indexPath.row)")
//
//        // возвращаем сконфигурированный экхемпляр ячейки
//        return cell
        
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        //имя контакта
        configuration.text = contacts[indexPath.row].title
        //номер телефона контакта
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
    
    
}

