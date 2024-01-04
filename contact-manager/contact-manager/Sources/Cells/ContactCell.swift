import UIKit

final class ContactCell: UITableViewCell {
    static let identifier = "ContactCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ContactCell {
    func configure(with contact: Contact) {
        var defaultContentConfiguration = defaultContentConfiguration()
        let text = "\(contact.name)(\(contact.age))"
        let secondaryText = contact.phoneNumber
        defaultContentConfiguration.text = text
        defaultContentConfiguration.secondaryText = secondaryText
        contentConfiguration = defaultContentConfiguration
    }
}
