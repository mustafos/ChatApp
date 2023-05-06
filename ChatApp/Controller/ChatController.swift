//
//  ChatController.swift
//  ChatApp
//
//  Created by Mustafa Bekirov on 06.05.2023.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: – Properties
    
    private let user: User
    
    // MARK: – Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        print("\(user.username)")
    }
    
    // MARK: – Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
    }
}
