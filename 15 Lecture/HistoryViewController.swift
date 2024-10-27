//
//  HistoryViewController.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//
// ისტორიის კონტროლერი, რომელიც აჩვენებს ყველა ჩატარებულ ოპერაციებს

import UIKit

class HistoryViewController: UIViewController {

    // ლეიბლი, რომელშიც გამოჩნდება ჩატარებული ოპერაციების ისტორია
    let operationsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0  // ლეიბლის ტექსტი შეიძლება იყოს მრავალსტრიქონიანი
        label.textAlignment = .right  // ტექსტის გასწორება მარჯვნივ
        label.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout-ის გამოყენება
        return label
    }()

    // viewDidLoad ფუნქცია, რომელიც იძახება კონტროლერის ჩატვირთვისას
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white  // ფონის ფერი თეთრად
        setupBackButton()  // უკან დაბრუნების ღილაკის დაყენება
        setupOperationsLabel()  // ოპერაციების ლეიბლის დაყენება
    }

    // უკან დაბრუნების ღილაკის პარამეტრების დაყენება
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout-ის გამოყენება
        
        let isDarkMode = traitCollection.userInterfaceStyle == .dark  // ვამოწმებთ ღამის რეჟიმს
        let iconName = isDarkMode ? "backLight" : "back"  //  რეჟიმის მიხედვით
        backButton.setImage(UIImage(named: iconName), for: .normal)  
        backButton.tintColor = .black  // ღილაკის ფერის დაყენება
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)  // ღილაკზე დაჭერის მოქმედების დამატება

        view.addSubview(backButton)  // ღილაკის დამატება View-ში
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),  // ზედა ფიქსაცია
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),  // მარცხენა ფიქსაცია
            backButton.widthAnchor.constraint(equalToConstant: 40),  // სიგანე
            backButton.heightAnchor.constraint(equalToConstant: 40)  // სიმაღლე
        ])
    }

    // ოპერაციების ლეიბლის პარამეტრების დაყენება
    private func setupOperationsLabel() {
        view.addSubview(operationsLabel)  // ლეიბლის დამატება View-ში
        NSLayoutConstraint.activate([
            operationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),  // მარჯვენა ფიქსაცია
            operationsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),  // ქვედა ფიქსაცია
            operationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)  // მარცხენა ფიქსაცია
        ])
    }

    // ფუნქცია, რომელიც იძახება უკან დაბრუნების ღილაკზე დაჭერისას
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)  // ეკრანის დახურვა ანიმაციით
    }

    // ფუნქცია, რომელიც განაახლებს ლეიბლს მიმდინარე ოპერაციებით
    func updateHistory(with operations: String) {
        operationsLabel.text = operations  // ოპერაციების ტექსტის მითითება ლეიბლში
    }
}
