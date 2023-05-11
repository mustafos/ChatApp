import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .systemGray6 : .systemMint
    }
    
    var messageTextColor: UIColor = .black
    
    init(message: Message) {
        self.message = message
    }
}
