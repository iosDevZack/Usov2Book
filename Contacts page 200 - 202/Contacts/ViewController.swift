//
//  ViewController.swift
//  Contacts
//
//  Created by Женя  on 21.02.22.
// Page 200 - 202 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - property
    
    private var contacts = [ContactProtocol]()
    
    var userDefaults = UserDefaults.standard
    var storage: ContactStorageProtocol!
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var contacts: [ContactProtocol] = [] {
            didSet {
                contacts.sort{ $0.title < $1.title }
                // сохранение контактов в хранилище
                storage.save(contacts: contacts)
            }
        }
        
        storage = ContactStorage()
        loadContacts()
        
    }
    
    //MARK: - Logic
    
    @IBAction func showNewContactAlert() {
        // создание Alert Controller
        let alertController = UIAlertController(title: "Create new contact", message: "Enter your name and phone number", preferredStyle: .alert)
        
        // Добавляем первое текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        // Добавляем второе текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Phone number" 
        }
        
        // Созданние кнопки
        // Кнопка создания контакта
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else { return }
            
            // Создаем новый контакт
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        // Кнопка отмены
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        // Добавляем кнопки в Alert Controller
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        // отображаем Alert Controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    private func loadContacts() {
        contacts = storage.load()
//        contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
//        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
//        contacts.append(Contact(title: "Сильвестр", phone: "+7000911112"))
   
    }


}

//MARK: - Extenssion TableView

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

extension ViewController: UITableViewDelegate {
    
    // Метод для свайпа ячейки влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Действие удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            // Удалаяем контакт
            self.contacts.remove(at: indexPath.row)
            // Заново формируем табличное представление
            tableView.reloadData()
        }
        // Формируем экземпляр, описывающий доступные действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

