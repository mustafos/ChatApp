import UIKit

class NewMessageController: UITableViewController {
    
    // MARK: – Properties
    
    // MARK: – Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: – Helpers
    
    func configureUI() {
        view.backgroundColor = .systemMint
    }
}
