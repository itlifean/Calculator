//
//  Button.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//
// ღილაკის კლასი, რომელიც მართავს კალკულატორის ღილაკების ფუნქციონირებას

import UIKit
 
final class CalcButton: UIButton {
    var value: String  // ღილაკის მნიშვნელობა, რომელიც განსაზღვრავს რას აკეთებს ღილაკი
    
    // ინიციალიზაცია ღილაკისთვის
    init(value: String = "") {
        self.value = value  // ღილაკის მნიშვნელობას ვანიჭებთ პარამეტრიდან მიღებულ მნიშვნელობას
        super.init(frame: .zero)  // ღილაკის ჩარჩო ინიციალიზდება ნულოვანი ზომით
        buttonCornerRadius()  // ვამრგვალებთ ღილაკის კუთხეებს
    }
    
    // საჭიროა, თუ წვდომა ხდება ინიციალიზაციისთვის Storyboard-დან ან NSCoder-დან
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ფუნქცია, რომელიც განსაზღვრავს ღილაკის კუთხეების ფორმას და ზომებს
    private func buttonCornerRadius() {
        self.clipsToBounds = true  // გარეთ გამოსული ელემენტები არ გამოჩნდეს, ღილაკი იყოს კუთხეებში დაბოლოებული
        self.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout-ის გამოყენების გამარტივებისთვის
        NSLayoutConstraint.deactivate(self.constraints)  // ვთიშავთ ღილაკის არსებულ constraints-ებს
        
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {  // ვამოწმებთ ეკრანის ორიანტაციას
            self.layer.cornerRadius = self.frame.width / 2  // კუთხეების რადიუსს ვანიჭებთ ნახევარს, რომ იყოს მრგვალი
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),  // სიმაღლე უდრის სიგანეს
            ])
        } else {
            self.layer.cornerRadius = 16  // ჰორიზონტალურ რეჟიმში კუთხეები ნაკლებად არის დამრგვალებული
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),  // სიმაღლე სიგანესთან შედარებით უფრო მცირეა
            ])
        }
    }
    
    // ღილაკის ვიზუალი და ქცევა სხვადასხვა პარამეტრის მიხედვით
    func setupButtonsUI(name: String = "", isDarkMode: Bool = false, isFilled: Bool = false, isBordered: Bool = false, iconLight: String = "", iconDark: String = "") {
        // ღილაკის ფერები ღამის და დღის რეჟიმისთვის
        let darkModeColor = UIColor(hue: 220/360, saturation: 0.11, brightness: 0.22, alpha: 1).cgColor  // მუქი ფერი ღამის რეჟიმისთვის
        let lightModeColor = UIColor(hue: 0, saturation: 0, brightness: 0.91, alpha: 1).cgColor  // ღია ფერი დღის რეჟიმისთვის
        
        if !name.isEmpty {
            self.setTitle(name, for: .normal)  // ღილაკზე ტექსტის დადგენა
            self.titleLabel?.font = UIFont.systemFont(ofSize: 24)  // ტექსტის შრიფტის ზომა
            value = name  // ვანიჭებთ ღილაკის მნიშვნელობას
        }
        
        if isFilled {
            self.layer.backgroundColor = isDarkMode ? darkModeColor : lightModeColor  // ფონური ფერის დადგენა რეჟიმის მიხედვით
        }

        if isBordered {
            self.layer.borderWidth = 2  // სიგანე საზღვრისთვის
            self.layer.borderColor = isDarkMode ? darkModeColor : lightModeColor  // საზღვრის ფერი
        }
        
        if !iconDark.isEmpty {
            self.setImage(UIImage(named: isDarkMode ? iconLight : iconDark), for: .normal) 
        }
    }

    // ტექსტის ფერის განახლება მუქი ან ღია რეჟიმის მიხედვით
    func updatetextColor(isDarkMode: Bool) {
        self.setTitleColor(isDarkMode ? .white : .black, for: .normal)  // ტექსტის ფერის შეცვლა
    }
    
    // ფუნქცია, რომელიც იძახება როდესაც ღილაკის ჩარჩო განახლდება
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonCornerRadius()  // ყოველ ჯერზე, როდესაც ვიუზე რაიმე იცვლება, განვაახლებთ კუთხეების ზომას
    }
}
