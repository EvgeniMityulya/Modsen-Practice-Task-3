//
//  FilterViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let startDate: Date? = nil
    private let endDate: Date? = nil
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let filterByDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel = CustomLabel(with: "Start date")
    private let startDateTextField = CustomTextField(with: "Select start date")
    private let calendarButton = IconButton(buttonType: .calendar)

    private let endDateLabel = CustomLabel(with: "End date")
    private let endDateTextField = CustomTextField(with: "Select end date")

    private let submitButton = CustomButton(with: "Submit")
    
    private let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .clear
        datePicker.addTarget(self, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .clear
        datePicker.addTarget(self, action: #selector(endDatePickerValueChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let startDatePickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let endDatePickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func startDatePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let selectedDate = dateFormatter.string(from: sender.date)
        startDateTextField.text = selectedDate
        startDatePickerContainerView.isHidden = true
    }
    
    @objc func endDatePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let selectedDate = dateFormatter.string(from: sender.date)
        endDateTextField.text = selectedDate
        endDatePickerContainerView.isHidden = true
    }
    
    @objc func openStartDatePicker() {
        if !endDatePickerContainerView.isHidden {
            endDatePickerContainerView.isHidden.toggle()
        }
        startDatePickerContainerView.isHidden.toggle()
    }
    
    @objc func openEndDatePicker() {
        if !startDatePickerContainerView.isHidden {
            startDatePickerContainerView.isHidden.toggle()
        }
        endDatePickerContainerView.isHidden.toggle()
    }
}

private extension FilterViewController {
    
    func setupUI() {
        self.view.backgroundColor = .black
        
        self.setupTargets()
                
        stackView.addArrangedSubview(
            filterByDateLabel,
            startDateLabel,
            startDateTextField,
            endDateLabel,
            endDateTextField,
            submitButton
        )
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
        ])
        
        startDatePickerContainerView.addSubview(startDatePicker)
        view.addSubview(startDatePickerContainerView)
        startDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            startDatePicker.topAnchor.constraint(equalTo: startDatePickerContainerView.topAnchor),
            startDatePicker.leadingAnchor.constraint(equalTo: startDatePickerContainerView.leadingAnchor),
            startDatePicker.trailingAnchor.constraint(equalTo: startDatePickerContainerView.trailingAnchor),
            startDatePicker.bottomAnchor.constraint(equalTo: startDatePickerContainerView.bottomAnchor),
            
            startDatePickerContainerView.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: 2),
            startDatePickerContainerView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            startDatePickerContainerView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ])
        
        endDatePickerContainerView.addSubview(endDatePicker)
        view.addSubview(endDatePickerContainerView)
        endDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            endDatePicker.topAnchor.constraint(equalTo: endDatePickerContainerView.topAnchor),
            endDatePicker.leadingAnchor.constraint(equalTo: endDatePickerContainerView.leadingAnchor),
            endDatePicker.trailingAnchor.constraint(equalTo: endDatePickerContainerView.trailingAnchor),
            endDatePicker.bottomAnchor.constraint(equalTo: endDatePickerContainerView.bottomAnchor),
            
            endDatePickerContainerView.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor, constant: 2),
            endDatePickerContainerView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            endDatePickerContainerView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func setupTargets() {
        // Create and configure startDateCalendarButton
        let startDateCalendarButton = IconButton(buttonType: .calendar)
        startDateCalendarButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        startDateCalendarButton.addTarget(self, action: #selector(openStartDatePicker), for: .touchUpInside)

        // Create a container view for startDateCalendarButton to add padding
        let startDateContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        startDateCalendarButton.center = CGPoint(x: startDateContainerView.frame.size.width - 16, y: startDateContainerView.frame.size.height / 2)
        startDateContainerView.addSubview(startDateCalendarButton)

        // Set startDateContainerView as the right view of startDateTextField
        startDateTextField.rightView = startDateContainerView
        startDateTextField.rightViewMode = .always

        // Create and configure endDateCalendarButton
        let endDateCalendarButton = IconButton(buttonType: .calendar)
        endDateCalendarButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        endDateCalendarButton.addTarget(self, action: #selector(openEndDatePicker), for: .touchUpInside)

        // Create a container view for endDateCalendarButton to add padding
        let endDateContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        endDateCalendarButton.center = CGPoint(x: endDateContainerView.frame.size.width - 16, y: endDateContainerView.frame.size.height / 2)
        endDateContainerView.addSubview(endDateCalendarButton)

        // Set endDateContainerView as the right view of endDateTextField
        endDateTextField.rightView = endDateContainerView
        endDateTextField.rightViewMode = .always
    }
}
