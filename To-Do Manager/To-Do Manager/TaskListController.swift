//
//  TaskListController.swift
//  To-Do Manager
//
//  Created by Женя  on 1.03.22.
//

import UIKit

class TaskListController: UITableViewController {
    
    //    В первую очередь необходимо подключить хранилище к контроллеру, в ко- тором оно будет использоваться, а также создать несколько дополнительных свойств.
    
    // хранилище задач
    var tasksStorage: TasksStorageProtocol = TasksStorage()
    
    // коллекция задач
    var tasks: [TaskPriority: [TaskProtocol]] = [:]
    
    // порядок отображения секций по типам
    // индекс в массиве соответствует индексу секции в таблице
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    
    // порядок отображения задач по их статусу
    var tasksStatusPosition: [TaskStatus] = [.planned, .completed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        В процессе загрузки сцены список задач из хранилища должен загружаться в контроллер для его последующего использования при наполнении табличного представления.
        
        // загрузка задач
        loadTasks()
        
    }
    
    private func loadTasks() {
        // подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция в таблице
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        
        // загрузка и разбор задач из хранилища
        tasksStorage.loadTasks().forEach { task in
            tasks[task.type]?.append(task)
        }
        
        // сортировка списка задач
        var tasks: [TaskPriority:[TaskProtocol]] = [:] {
            didSet {
                for (tasksGroupPriority, tasksGroup) in tasks {
                    tasks[tasksGroupPriority] = tasksGroup.sorted{ task1, task2 in
                        let task1position = tasksStatusPosition.firstIndex(of: task1.status) ?? 0
                        let task2position = tasksStatusPosition.firstIndex(of: task2.status) ?? 0
                        return task1position < task2position
                        
                    }
                }
            }
        }
    }
    
    //    Теперь посмотрим, как будет выглядеть таблица при использовании прото- типа, основанного на применении Horizontal Stack View и кастомного класса TaskCell.
    
    // ячейка на основе стека
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        
        // получаем данные о задаче, которые необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        
        // изменяем текст в ячейке
        cell.title.text = currentTask.title
        // изменяем символ в ячейке
        cell.symbol.text = getSymbolForTask(with: currentTask.status)
        
        
        // изменяем цвет текста
        if currentTask.status == .planned {
            cell.title.textColor = .black
            cell.symbol.textColor = .black
        } else {
            cell.title.textColor = .lightGray
            cell.symbol.textColor = .lightGray
        }
        
        return cell
    }
    
    // MARK: - Table view data source
    
    // количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    // количество строк в определенной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // определяем приоритет задач, соответствующий текущей секции
        let taskType = sectionsTypesPosition[section]
        guard let currentTasksType = tasks[taskType] else {
            return 0 }
        return currentTasksType.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        return getConfiguredTaskCell_constraints(for: indexPath)
        
        // ячейка на основе констрейнтов
        return getConfiguredTaskCell_constraints(for: indexPath)
        
        // ячейка на основе стека
        return getConfiguredTaskCell_stack(for: indexPath)
        
    }
    
    // ячейка на основе ограничений
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
        
        // получаем данные о задаче, которую необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell }
        
        
        // текстовая метка символа
        let symbolLabel = cell.viewWithTag(1) as? UILabel
        // текстовая метка названия задачи
        let textLabel = cell.viewWithTag(2) as? UILabel
        
        // изменяем символ в ячейке
        symbolLabel?.text = getSymbolForTask(with: currentTask.status)
        // изменяем текст в ячейке
        textLabel?.text = currentTask.title
        
        // изменяем цвет текста и символа
        if currentTask.status == .planned {
            textLabel?.textColor = .black
            symbolLabel?.textColor = .black
        } else {
            textLabel?.textColor = .lightGray
            symbolLabel?.textColor = .lightGray
        }
        return cell
    }
    
    // возвращаем символ для соответствующего типа задачи
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    // Метод заголовка для секций
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important {
            title = "Важные"
        } else if tasksType == .normal {
            title = "Текущие"
        }
        return title
    }
    
    //Метод нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1. Проверяем существование задачи
        //        Для обеспечения безопасности работы (чтобы избежать внезапных падений приложения) происходит проверка того, что в свойстве tasks существует задача, соответствующая нажатой строке.
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return }
        
        // 2. Убеждаемся, что задача не является выполненной
        //        Далее происходит проверка условия, что выбранная задача не является выполненной. Нажатие на выполненную задачу не должно изменять статус на «запланированная» — для этого будет использоваться свайп.
        guard tasks[taskType]![indexPath.row].status == .planned else {
            // снимаем выделение со строки
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        // 3. Отмечаем задачу как выполненную
        tasks[taskType]![indexPath.row].status = .completed
        
        // 4. Перезагружаем секцию таблицы
        //        Само по себе изменение значения свойства tasks не приведет к обновлению табличного представления. Для того, чтобы на экране отобразились актуальные данные, требуется принудительно вызвать обновление списка задач. Ранее с этой целью мы обращались к методу reloadData, но в данном случае используется reloadSections, который позволяет обновить только требуемые секции, а не всю таблицу целиком
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    
    
}
