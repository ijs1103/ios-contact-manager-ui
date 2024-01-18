import UIKit

struct AlertService {
    weak var viewController: UIViewController?

    func alertInvalidInput(alertMessage: AlertService.Message) {
        guard let viewController else { return }
        let alert = AlertBuilder()
            .setMessage(String(describing: alertMessage))
            .addAction(title: "확인", style: .default, handler: nil)
            .build()
        viewController.present(alert, animated: true)
    }
    
    func alertCancelConfirmation() {
        guard let viewController else { return }
        let cancelConfirmationMessage = AlertService.Message.cancelConfirmation

        let alert = AlertBuilder()
            .setMessage(String(describing: cancelConfirmationMessage))
            .addAction(title: "예", style: .destructive) { _ in
                viewController.presentingViewController?.dismiss(animated: true)
            }
            .addAction(title: "아니오", style: .cancel, handler: nil)
            .build()
        viewController.present(alert, animated: true)
    }
    
    func alertNonExistentContact() {
        guard let viewController else { return }
        let nonExistentContactMessage = AlertService.Message.nonExistentContact

        let alert = AlertBuilder()
            .setMessage(String(describing: nonExistentContactMessage))
            .addAction(title: "확인", style: .default, handler: nil)
            .build()
        viewController.present(alert, animated: true)
    }
}

extension AlertService {
    enum Message: CustomStringConvertible {
        case cancelConfirmation
        case invalidName
        case invalidAge
        case invalidPhoneNumber
        case nonExistentContact
        
        var description: String {
            switch self {
            case .cancelConfirmation:
                "정말로 취소하시겠습니까?"
            case .invalidName:
                "입력한 이름 정보가 잘못되었습니다."
            case .invalidAge:
                "입력한 나이 정보가 잘못되었습니다."
            case .invalidPhoneNumber:
                "입력한 연락처 정보가 잘못되었습니다."
            case .nonExistentContact:
                "존재하지 않는 연락처입니다."
            }
        }
    }
}
