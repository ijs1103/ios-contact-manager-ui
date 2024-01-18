import UIKit

final class ContactListViewController: UIViewController {
    
    private let alertService = AlertService()
    private let contactManager: ContactManager

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let addContactButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
        configureNavigationBar(on: navigationBar, title: "연락처", rightButton: addContactButton)
        return navigationBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    init(contactManager: ContactManager) {
        self.contactManager = contactManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension ContactListViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        view.bringSubviewToFront(navigationBar)
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc private func addContactButtonTapped() {
        let newContactViewController = NewContactViewController(contactManager: contactManager, onDismiss: reloadContactList)
        present(newContactViewController, animated: true)
    }
    
    private func reloadContactList() {
        tableView.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            fatalError("ContactCell load Failed")
        }
        let contact = contactManager.contacts[indexPath.row]
        cell.configure(with: contact)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let phoneNumber = contactManager.contacts[indexPath.row].phoneNumber
        if editingStyle == .delete {
            do {
                try contactManager.deleteContact(phoneNumber: phoneNumber)
            } catch ContactManager.ContactError.nonExistentContact {
                alertService.alertNonExistentContact()
            } catch {
                print("unknown error")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

