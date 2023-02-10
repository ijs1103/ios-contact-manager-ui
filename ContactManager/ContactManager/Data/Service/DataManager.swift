//
//  DataManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    var contacts: Set<Person> = Set<Person>()
        
    private init() { }
    
    func setContact(_ person: Person) {
        contacts.insert(person)
    }
    
    func getContactsData() -> Set<Person> {
        return contacts
    }
    
    func getcontactsDataAsPerson() -> [Person] {
        let datas = contacts.map { $0 }
        let sortedDatas = datas.sorted()
        return sortedDatas
    }
    
    func getContactsList() -> [String] {
        let contacts = contacts.map { "- \($0.name) / \($0.age) / \($0.phoneNum)" }
        return contacts
    }
    
    func countContactLists() -> Int {
        return contacts.count
    }
    
    func deleteContact(of data: Person) {
        contacts.remove(data)
    }
}
