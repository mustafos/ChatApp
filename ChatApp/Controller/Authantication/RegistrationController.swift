import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class RegistrationController: UIViewController {
    
    // MARK: – Properties
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .white
        button.addTarget(RegistrationController.self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
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
        button.isEnabled = false
        button.addTarget(RegistrationController.self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(RegistrationController.self, action: #selector(handlerShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: – Selectors
    
    @objc func handleRegistration() {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text?.lowercased() else { return }
        guard let profileImage = profileImage else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password, username: username, profileImage: profileImage)
        
        showLoader(true, withText: "Signing You Up")
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                self.showLoader(false)
                self.showError(error.localizedDescription)
                return
            }
            self.showLoader(false)
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
}

// MARK: – UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        plusPhotoButton.setImage(image, for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        dismiss(animated: true)
    }
}

extension RegistrationController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = .systemRed
        } else {
            signupButton.isEnabled = false
        }
    }
}


