//
//  ViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/09/28.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    @IBOutlet weak var idTextView: VerifyTextView!
    @IBOutlet weak var firstPWTextView: SecureVerifyTextView!
    @IBOutlet weak var secondPWTextView: SecureVerifyTextView!
    @IBOutlet weak var nameTextView: VerifyTextView!
    @IBOutlet weak var nextButton: UIButton!
    
    let idViewModel = VerifyTextViewModel(validator: IdValidator())
    let firstPWViewModel = VerifyTextViewModel(validator: PwValidator())
    let nameViewModel = VerifyTextViewModel(validator: NameValidator())
    let signUpViewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldDataSource()
        bindRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        nextButton.layer.cornerRadius = 5
    }
    
    private func setupTextFieldDataSource() {
        idTextView.dataSource = IdDataSource()
        firstPWTextView.dataSource = FirstPWDataSource()
        secondPWTextView.dataSource = SecondPWDataSource()
        nameTextView.dataSource = NameDataSource()
    }
    
    private func bindRx() {
        bindVerifyTextView(view: idTextView, viewModel: idViewModel)
        bindVerifyTextView(view: firstPWTextView, viewModel: firstPWViewModel)
        bindVerifyTextView(view: nameTextView, viewModel: nameViewModel)
        bindSecondPassword()
    }
    
    private func bindSecondPassword() {
        let first = firstPWTextView.textField.rx.text.orEmpty
        let second = secondPWTextView.textField.rx.text.orEmpty
        // input
        Observable.combineLatest(first, second)
            .debounce(.milliseconds(1500), scheduler: ConcurrentMainScheduler.instance )
            .bind(to: signUpViewModel.passwordsCombine)
            .disposed(by: disposeBag)
        
        // output
        signUpViewModel.passwordsCombine
            .filter{ $0.0.count != 0 && $0.1.count != 0 }
            .map { $0.0 == $0.1 }
            .subscribe(onNext: { [weak self] in
                self?.signUpViewModel.isPWEqual = $0
                if $0 {
                    self?.secondPWTextView.updateUIPass(msg: .equalPassword)
                } else {
                    self?.secondPWTextView.updateUIFail(msg: .notEqualPassward)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindVerifyTextView(view verifyView: VerifyTextView,
                            viewModel verifyViewModel: VerifyTextViewModel) {
        // input
        verifyView.textField.rx.text.orEmpty
            .filter{ $0.count != 0 }
            .debounce(.milliseconds(1500), scheduler: ConcurrentMainScheduler.instance )
            .bind(to: verifyViewModel.textFieldValueChanged)
            .disposed(by: disposeBag)
        
        // output
        verifyViewModel.inputDidValidate
            .subscribe(onNext: { msg in
                if msg == verifyViewModel.pass {
                    verifyView.updateUIPass(msg: msg)
                } else {
                    verifyView.updateUIFail(msg: msg)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func saveUserInfo() {
        let id = idTextView.textField.text ?? ""
        let password = firstPWTextView.textField.text ?? ""
        let name = nameTextView.textField.text ?? ""
    
        let user = User(id: id, password: password, name: name)
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.setValue(data, forKey: "userinfo")
    }

    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func nextOnTouch(_ sender: Any) {
        if idViewModel.status && firstPWViewModel.status
            && signUpViewModel.isPWEqual && nameViewModel.status {
            saveUserInfo()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let itemList = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
            itemList.transitioningDelegate = self
            self.present(itemList, animated: true)
        }
    }
}

extension SignUpViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator()
    }
}
