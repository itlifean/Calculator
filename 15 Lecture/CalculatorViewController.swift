//
//  CalculatorViewController.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//

import UIKit


final class CalculatorViewController: UIViewController {
    // ისტორიის ღილაკი

    
    // ციფების ღილაკები
    private let buttonZero = CalcButton()
    private let buttonOne = CalcButton()
    private let buttonTwo = CalcButton()
    private let buttonThree = CalcButton()
    private let buttonFour = CalcButton()
    private let buttonFive = CalcButton()
    private let buttonSix = CalcButton()
    private let buttonSeven = CalcButton()
    private let buttonEight = CalcButton()
    private let buttonNine = CalcButton()

    // წერტილის ღილაკი
    private let decimalButton = CalcButton()
    
    // ოპერაციების ღილაკები
    private let percentButton = CalcButton(value: "%")
    private let divideButton = CalcButton(value: "/")
    private let mulitpleButton = CalcButton(value: "*")
    private let substractButton = CalcButton(value: "-")
    private let addButton = CalcButton(value: "+")
    private let clearButton = CalcButton()// (AC)
    private let equalsButton = CalcButton()// (=)
    
    // თემის ცვლილების ღილაკი (დარქ/ლაით მოდი)
    private let themeToggleButton = CalcButton()
    
    // ბულები თმის რეჟიმისთვის და შედეგებისათვის
    private var isDarkMode = true
    private var isCalculatedResult = false
    
    // შედეგები
    private let resultsView = UIView()
    private let firstLabel = UILabel()
    private var secondLabel = UILabel()
    
    // გრადიენტის ფენა
    let gradientLayer = CAGradientLayer()
    
    // UIView კლავიატურის ზონისთვის
    private let keyPadView = UIView()
    
    // ძირითადი UIStackView ყველა რიცხვის და ღილაკების ორგანიზებისთვის
    private let mainNumStackView = UIStackView()
    
    // სტეკები რიცხვების გასანაწილებლად
    private let firstRowStack = UIStackView()
    private let secondRowStack = UIStackView()
    private let thirdRowStack = UIStackView()
    private let fourthRowStack = UIStackView()
    private let fifthRowStack = UIStackView()
    
    // ოპერაციების სია
    private var lastOperations: [String] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradient()
        
        
    }
    
    override func viewDidLoad() {

        
        let historyButton = HistoryButton()
        view.addSubview(historyButton)
        view.bringSubviewToFront(historyButton)

        historyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            historyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            historyButton.widthAnchor.constraint(equalToConstant: 40),
            historyButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        print("HistoryButton added to CalculatorViewController")
        
    super.viewDidLoad()
    view.addSubview(historyButton)
    view.bringSubviewToFront(historyButton)
    historyButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        historyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        historyButton.widthAnchor.constraint(equalToConstant: 40),
        historyButton.heightAnchor.constraint(equalToConstant: 40)
    ])
    
        configureUI()
        
    }
    
    
    private func configureUI(){
        
        
        addNumberRows()
        configureButtons()
        configureStackView()
        configureResulstView()
        configureLabels()
        configureNumpad()
        configureNumStackView()
        applyGradient()
        toggleThemeMode()
    }
    
    
    // ფუნქცია, რომელიც აკონფიგურირებს ლეიბლებს
    private func configureLabels() {
        setupSecondaryLabel()
        setupPrimaryLabel()
    }
   
 
   
    
    // ფუნქცია, რომელიც აწყობს შედეგების ვიუს
    private func configureResulstView() {
        view.addSubview(resultsView)
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            resultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    // ფუნქცია, რომელიც აწყობს ლეიბლს (პატარა ტექსტის ველი)
    
    private func setupPrimaryLabel() {
        resultsView.addSubview(firstLabel)
        firstLabel.text = ""
        firstLabel.font = UIFont.preferredFont(forTextStyle: .body)
        firstLabel.textColor = UIColor.systemGray
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.trailingAnchor.constraint(equalTo: secondLabel.trailingAnchor),
            firstLabel.bottomAnchor.constraint(equalTo: secondLabel.topAnchor, constant: -8)
        ])
    }
    
    // ფუნქცია, რომელიც აწყობს მეორე ლეიბლს
    private func setupSecondaryLabel() {
        resultsView.addSubview(secondLabel)
        secondLabel.text = "0"
        secondLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        secondLabel.textColor = .label
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.trailingAnchor.constraint(equalTo: resultsView.trailingAnchor, constant: -16),
            secondLabel.bottomAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: -20)
        ])
    }
    
    // ფუნქცია, რომელიც ცვლის თემას (light/dark რეჟიმები)
    @objc private func toggleThemeMode() {
        isDarkMode = !isDarkMode
        if isDarkMode {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        updateUI()
    }
    
    // ფუნქცია, რომელიც აწყობს პანელის UI-ს
    private func configureNumpad() {
        view.addSubview(keyPadView)
        keyPadView.translatesAutoresizingMaskIntoConstraints = false
        keyPadView.clipsToBounds = true
        keyPadView.layer.cornerRadius = 28
        // მხოლოდ ზედა კუთხეების მომრგვალება (მარჯვენა და მარცხენა ზედა კუთხეები)
        keyPadView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        // Auto Layout-ის გამოყენებით ვამაგრებთ keyPadView-ს მთავარ ვიუზე
        NSLayoutConstraint.activate([
            keyPadView.topAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: 16),
            keyPadView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            keyPadView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            keyPadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // ფუნქცია, რომელიც აწყობს მთავარ StackView-ს ღილაკების პანელში (keyPadView-ში)
    private func configureNumStackView() {
        keyPadView.addSubview(mainNumStackView)
        // Auto Layout-ის გამოყენება, რომ შევძლოთ დინამიური ზომების მართვა
        mainNumStackView.translatesAutoresizingMaskIntoConstraints = false
        // ღილაკების განლაგების მიმართულება ჰორიზონტალური იქნება
        mainNumStackView.axis = .horizontal
        mainNumStackView.distribution = .fillEqually
        mainNumStackView.spacing = 16
        NSLayoutConstraint.activate([
            mainNumStackView.leftAnchor.constraint(equalTo: keyPadView.leftAnchor, constant: 42),
            mainNumStackView.rightAnchor.constraint(equalTo: keyPadView.rightAnchor, constant: -42),
            mainNumStackView.topAnchor.constraint(equalTo: keyPadView.topAnchor, constant: 48),
            mainNumStackView.bottomAnchor.constraint(equalTo: keyPadView.bottomAnchor, constant: -66)
        ])
    }
    // ფუნქცია, რომელიც ღილაკების რიგებს აწყობს მთავარ StackView-ში
    private func addNumberRows() {
        // ვქმნით სტეკების მასივს, სადაც ყველა რიგი გვექნება (სტრიქონები)
        let stackArray = [firstRowStack, secondRowStack, thirdRowStack, fourthRowStack]
        // ვატრიალებთ მასივში ყველა სტეკზე
        stackArray.forEach { stack in
            // ვერტიკალური განლაგება ღილაკებისთვის, რომ ღილაკები იყოს ქვემოდან ზემოთ
            stack.axis = .vertical
            // ღილაკებს შორის მანძილი 16 პიქსელი
            stack.spacing = 16
            // ვამატებთ თითოეულ სტეკს მთავარ StackView-ში, რომ გამოჩნდეს
            mainNumStackView.addArrangedSubview(stack)
        }
    }
    
    private func configureButtons() {
        // თითოეული ღილაკისთვის ვაწყობთ UI-ს და ვაყენებთ შესაბამის სახელებს
        clearButton.setupButtonsUI(name: "AC")
        buttonZero.setupButtonsUI(name: "0")
        buttonOne.setupButtonsUI(name: "1")
        buttonTwo.setupButtonsUI(name: "2")
        buttonThree.setupButtonsUI(name: "3")
        buttonFour.setupButtonsUI(name: "4")
        buttonFive.setupButtonsUI(name: "5")
        buttonSix.setupButtonsUI(name: "6")
        buttonSeven.setupButtonsUI(name: "7")
        buttonEight.setupButtonsUI(name: "8")
        buttonNine.setupButtonsUI(name: "9")
        decimalButton.setupButtonsUI(name: ".")
        equalsButton.setupButtonsUI(name: "=")
        // მასივი, რომელიც შეიცავს ყველა ღილაკს შემდგომი დამუშავებისთვის
        let buttonsArray: [CalcButton] = [
            buttonZero,
            buttonOne,
            buttonTwo,
            buttonThree,
            buttonFour,
            buttonFive,
            buttonSix,
            buttonSeven,
            buttonEight,
            buttonNine,
            decimalButton,
            clearButton,
            percentButton,
            divideButton,
            mulitpleButton,
            substractButton,
            addButton
        ]
        // თემის შეცვლის ღილაკზე მოქმედების დამატება (დარკ/ლაით რეჟიმი)
        themeToggleButton.addTarget(self, action: #selector(toggleThemeMode), for: .touchUpInside)
        // ვატრიალებთ ყველა ღილაკს მასივში და თითოეულს ვამატებთ მოქმედებას
        buttonsArray.forEach { button in
            // თითოეულ ღილაკს ვამატებთ მოქმედებას (touchUpInside)
            button.addAction(UIAction(handler: { [weak self] action in
                // ღილაკზე დაჭერისას ვიძახებთ addButtonAction ფუნქციას და გადავცემთ ღილაკის მნიშვნელობას
                self?.addButtonAction(value: button.value)
            }), for: .touchUpInside)
        }
        // "=" ღილაკზე ცალკე მოქმედების დამატება, რომელიც გამოიძახებს კალკულატორის ფუნქციას
        equalsButton.addAction(UIAction(handler: { [weak self] action in
            self?.useCalculator()
        }), for: .touchUpInside)
    }
    // ფუნქცია, რომელიც ანახლებს UI-ს თემის ცვლილების შემდეგ (დარკ/ლაით რეჟიმი)
    private func updateUI() {
        // ვიუზე ფონის ფერის შეცვლა თემის მიხედვით
        view.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.15, alpha: 1) : UIColor.white
        // keyPadView ფონის ფერის შეცვლა თემის მიხედვით
        keyPadView.backgroundColor = isDarkMode ? UIColor(hue: 220/360, saturation: 0.15, brightness: 0.18, alpha: 1) : UIColor(hue: 0/360, saturation: 0, brightness: 0.96, alpha: 1)
        
        updateButtonIconsColor()
        updateButtonTitleColor()
    }
    // ფუნქცია, რომელიც ანახლებს ღილაკების აიკონების ფერებს
    private func updateButtonIconsColor() {
        // თემის შეცვლისას ვაწყობთ ღილაკების აიკონებს
        themeToggleButton.setupButtonsUI(isDarkMode: isDarkMode, isBordered: true, iconLight: "sun", iconDark: "moon")
        // "%" ღილაკის აიკონის განახლება
        percentButton.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "percentLight", iconDark: "percent")
        // "÷" ღილაკის აიკონის განახლება
        divideButton.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "divideLight", iconDark: "divide")
        // "×" ღილაკის აიკონის განახლება
        mulitpleButton.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "multipleLight", iconDark: "multiple")
        // "+" ღილაკის აიკონის განახლება
        addButton.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "incrementLight", iconDark: "increment")
        // "-" ღილაკის აიკონის განახლება
        substractButton.setupButtonsUI(isDarkMode: isDarkMode, isFilled: true, iconLight: "decrementLight", iconDark: "decrement")
    }
    
    // ფუნქცია, რომელიც ანახლებს ღილაკების ტექსტის ფერებს
    private func updateButtonTitleColor() {
        // ვამუშავებთ ყველა ციფრულ ღილაკს და განვაახლებთ მათი ტექსტის ფერს თემის შესაბამისად
        buttonZero.updatetextColor(isDarkMode: isDarkMode)
        buttonOne.updatetextColor(isDarkMode: isDarkMode)
        buttonTwo.updatetextColor(isDarkMode: isDarkMode)
        buttonThree.updatetextColor(isDarkMode: isDarkMode)
        buttonFour.updatetextColor(isDarkMode: isDarkMode)
        buttonFive.updatetextColor(isDarkMode: isDarkMode)
        buttonSix.updatetextColor(isDarkMode: isDarkMode)
        buttonSeven.updatetextColor(isDarkMode: isDarkMode)
        buttonEight.updatetextColor(isDarkMode: isDarkMode)
        buttonNine.updatetextColor(isDarkMode: isDarkMode)
        // "AC" და წერტილის ღილაკებისთვის ტექსტის ფერის განახლება
        clearButton.updatetextColor(isDarkMode: isDarkMode)
        decimalButton.updatetextColor(isDarkMode: isDarkMode)
    }
    // ფუნქცია, რომელიც აწყობს StackView-ს ღილაკებით
    private func configureStackView() {
        // პირველი რიგის ღილაკები
        let firstLine = [themeToggleButton, buttonSeven, buttonFour, buttonOne, clearButton]
        firstLine.forEach { button in
            // ვამატებთ ღილაკებს პირველ სტეკში
            firstRowStack.addArrangedSubview(button)
            // თანაბარი განაწილება ღილაკების
            firstRowStack.distribution = .fillEqually
        }
        
        // მეორე რიგის ღილაკები
        let secondLine = [percentButton, buttonEight, buttonFive, buttonTwo, buttonZero]
        secondLine.forEach { button in
            // ვამატებთ ღილაკებს მეორე სტეკში
            secondRowStack.addArrangedSubview(button)
            // თანაბარი განაწილება ღილაკების
            secondRowStack.distribution = .fillEqually
        }
        
        // მესამე რიგის ღილაკები
        let thirdLine = [divideButton, buttonNine, buttonSix, buttonThree, decimalButton]
        thirdLine.forEach { button in
            // ვამატებთ ღილაკებს მესამე სტეკში
            thirdRowStack.addArrangedSubview(button)
            // თანაბარი განაწილება ღილაკების
            thirdRowStack.distribution = .fillEqually
        }
        
        // მეოთხე რიგის ღილაკები (მთავარი ოპერაციების ღილაკები)
        let fourthLine = [mulitpleButton, substractButton, addButton, equalsButton]
        fourthLine.forEach { button in
            // ვამატებთ ღილაკებს მეოთხე სტეკში
            fourthRowStack.addArrangedSubview(button)
            // პროპორციული განაწილება, რომ ოპერაციების ღილაკები იყოს სხვადასხვა ზომის
            fourthRowStack.distribution = .fillProportionally
            // ვაკონფიგურირებთ დაშორებას ღილაკებს შორის
            fourthRowStack.spacing = 18
        }
    }
    // ფუნქცია, რომელიც ადებს გრადიენტს ღილაკს
    private func applyGradient() {
        // გრადიენტის ზომა ტოლის ღილაკის ზომის მიხედვით
        gradientLayer.frame = equalsButton.bounds
        // გრადიენტის მომრგვალება ტოლის ღილაკის კუთხეების მიხედვით
        gradientLayer.cornerRadius = equalsButton.layer.cornerRadius
        // გრადიენტის ფერები (ვარდისფერი და ნარინჯისფერი)
        gradientLayer.colors = [
            UIColor(hue: 323/360, saturation: 0.94, brightness: 0.93, alpha: 1).cgColor,  // ვარდისფერი
            UIColor(hue: 13/360, saturation: 0.82, brightness: 1, alpha: 1).cgColor,      // ნარინჯისფერი
        ]
        // გრადიენტის დამატება ტოლობის ღილაკის ფენაში
        equalsButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    // შედეგი
    private func useCalculator() {
        // ვამოწმებთ, რომ მეორე ლეიბლზე არის ტექსტი, თუ არა, ვაბრუნებთ return-ს
        guard let resText = secondLabel.text else { return }
        // NSExpression-ის გამოყენებით ვამუშავებთ ტექსტს, როგორც მათემატიკურ ფორმულას
        let expn = NSExpression(format: resText)
        // პირველ ლეიბლზე (firstLabel) ვაყენებთ ტექსტს, რომელიც იყო მეორე ლეიბლზე
        firstLabel.text = String(describing: secondLabel.text ?? "")
        // ვანგარიშობთ შედეგს და ვანახლებთ მეორე ლეიბლს გამოთვლილი მნიშვნელობით
        secondLabel.text = String(reflecting: expn.expressionValue(with: nil, context: nil) ?? "0")
        // ვაყენებთ მნიშვნელობას, რომ შედეგი გამოთვლილია
        isCalculatedResult = true
        // ვამატებთ ბოლო შესრულებულ ოპერაციას ბოლო ოპერაციების მასივში
        lastOperations.append(firstLabel.text ?? "")
    }
    // ფუნქცია, რომელიც ღილაკის მოქმედებას ამუშავებს (value - ღილაკის მნიშვნელობა)
    private func addButtonAction(value: String) {
        // სიმბოლოები, რომლებიც წარმოადგენენ ოპერატორებს
        let symbols = ["%", "/", "*",  "-", "+", "."]
        // თუ ბოლო სიმბოლო უკვე ოპერატორია და ახალი მნიშვნელობაც ოპერატორია, წავშლით ბოლო სიმბოლოს
        if symbols.contains(String(secondLabel.text?.last ?? ".")) && symbols.contains(value) {
            let droppedWord = secondLabel.text!.dropLast()
            secondLabel.text = String(Substring(droppedWord))
        }
        // თუ ღილაკი "AC" არის, მეორე ლეიბლს "0"-ს
        if value == "AC" {
            secondLabel.text = "0"
            // თუ მეორე ლეიბლზე უკვე 0 წერია ან შედეგი გამოთვლილია და ახალი ღირებულება არ არის ოპერატორი
        } else if secondLabel.text == "0" || isCalculatedResult && !symbols.contains(value) {
            // ვანახლებთ მეორე ლეიბლს ახალ ღირებულებით
            secondLabel.text! = value
            // აღარაა გამოთვლილი შედეგი
            isCalculatedResult = false
        } else {
            // თუ სხვა შემთხვევაა, ვამატებთ ახალ ღირებულებას არსებულ ტექსტს
            secondLabel.text! += value
            // აღარაა გამოთვლილი შედეგი
            isCalculatedResult = false
        }
    }
}
    #Preview {
        let viewController = CalculatorViewController()
        return viewController
    }

     

