//
//  ContactsViewController.swift
//  ContactManagerUI
//
//  Created by jun on 2023/01/31.
//

import UIKit

final class ContactsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var contacts = [
        Contact(name: "james", age: 30, phoneNumber: "05-343-2234"),
        Contact(name: "steven", age: 100, phoneNumber: "047-221-3432"),
        Contact(name: "hajin", age: 33, phoneNumber: "010-3332-0093"),
        Contact(name: "mini", age: 99, phoneNumber: "0323-33-2232"),
        Contact(name: "hojun", age: 45, phoneNumber: "3-444-19343"),
        Contact(name: "dooly", age: 95, phoneNumber: "932-39443-23"),
        Contact(name: "lucy", age: 1, phoneNumber: "000-232-03333"),
        Contact(name: "yo", age: 30, phoneNumber: "323-43-3333"),
        Contact(name: "joy", age: 65, phoneNumber: "6894-3-3434"),
        Contact(name: "summer", age: 84, phoneNumber: "9-32-343323"),
        Contact(name: "green", age: 54, phoneNumber: "895-3432-344"),
        Contact(name: "jisu", age: 30, phoneNumber: "05-343-2234"),
        Contact(name: "hana", age: 100, phoneNumber: "047-221-3432"),
        Contact(name: "mike", age: 33, phoneNumber: "010-3332-0093"),
        Contact(name: "coco", age: 99, phoneNumber: "0323-33-2232"),
        Contact(name: "tiger", age: 45, phoneNumber: "3-444-19343"),
        Contact(name: "molly", age: 95, phoneNumber: "932-39443-23"),
        Contact(name: "Joo", age: 5, phoneNumber: "010-1234-1234"),
        Contact(name: "june", age: 4, phoneNumber: "010-5678-5678")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: ContactTableViewCell.className, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: ContactTableViewCell.className)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
           let newContactViewController = navigationController.viewControllers.first as? NewContactViewController {
            newContactViewController.delegate = self
        }
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ContactTableViewCell.className,
            for: indexPath
        ) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(contact: contacts[indexPath.row])
        return cell
    }
}

extension ContactsViewController: NewContactViewControllerDelegate {
    func sendData(contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
