import UIKit

class RegistrationController: UIViewController {
    
    // MARK: – Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    }()
    
    private lazy var usernameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "person.crop.rectangle"), textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock.rectangle"), textField: passwordTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.0
        button.layer.borderColor = (UIColor(red: 163, green: 228, blue: 237, alpha: 100)).cgColor
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlerShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: – Selectors
    
    @objc func handleSelectPhoto() {
        print("Select photo here...")
    }
    
    @objc func handlerShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: – Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32, width: 200, height: 200)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   usernameContainerView,
                                                   passwordContainerView,
                                                   signupButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32,
                     paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
}

