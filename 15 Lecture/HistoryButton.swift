//
//  HistoryButton.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//
// ისტორიის ღილაკი, რომელიც აჩვენებს შესრულებული ოპერაციების ისტორიას

import UIKit

class HistoryButton: UIButton {

    // ინიციალიზაცია, რომელიც იძახებს ღილაკის დასაყენებელ ფუნქციას
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHistoryButton()
    }

    // ინიციალიზაცია, რომელიც საჭიროა Storyboard-ის ან NSCoder-ის გამოყენებისას
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHistoryButton()
    }

    // ღილაკის ძირითადი პარამეტრების და ხატულის განსაზღვრა
    private func setupHistoryButton() {
        self.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout-ის გამოყენებისთვის
        updateHistoryButtonIcon(isDarkMode: traitCollection.userInterfaceStyle == .dark)  // ხატულის განახლება რეჟიმის მიხედვით
        self.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)  // ღილაკზე დაჭერის მოქმედების დამატება
    }

    // ფუნქცია, რომელიც იძახება, როდესაც ღილაკის ჩარჩო განახლდება
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // ვამოწმებთ, რომ ღილაკი ემაგრებოდეს superview-ს
        if let superview = self.superview {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 16),  // ზედა ფიქსაცია
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),  // მარცხენა ფიქსაცია
                self.widthAnchor.constraint(equalToConstant: 40),  // სიგანე
                self.heightAnchor.constraint(equalToConstant: 40)  // სიმაღლე
            ])
        }

        updateHistoryButtonIcon(isDarkMode: traitCollection.userInterfaceStyle == .dark)  // განახლება რეჟიმის მიხედვით
    }

    // ფუნქცია, რომელიც განაახლებს ღილაკს დღის ან ღამის რეჟიმის მიხედვით
    func updateHistoryButtonIcon(isDarkMode: Bool) {
        let iconName = isDarkMode ? "historyLight" : "history"  //  სახელი დამოკიდებულია დღის ან ღამის რეჟიმზე
        if let image = UIImage(named: iconName) {
            self.setImage(image, for: .normal)  //  დასმა ღილაკზე
        }
    }

    // ფუნქცია, რომელიც იძახება, როდესაც ისტორიის ღილაკზე დააჭერს მომხმარებელი
    @objc private func historyButtonTapped() {
        guard let topController = findTopViewController() else {
            print("Top controller not found!")  // შეცდომის შეტყობინება, თუ ზედა კონტროლერი ვერ მოიძებნა
            return
        }
        let historyVC = HistoryViewController()  // ისტორიის ეკრანის კონტროლერის შექმნა
        topController.present(historyVC, animated: true, completion: nil)  // ისტორიის ეკრანის ჩვენება
    }

    // ფუნქცია, რომელიც ეძებს აპლიკაციის ზედა ViewController-ს
    private func findTopViewController() -> UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           let rootVC = window.rootViewController {
            
            var topController = rootVC
            while let presentedVC = topController.presentedViewController {
                topController = presentedVC  // მოვძებნით ყველაზე ზედა ViewController-ს
            }
            return topController  // დაბრუნდება ზედა ViewController
        }
        return nil  // თუ ვერ მოიძებნა, დაბრუნდება nil
    }
}

