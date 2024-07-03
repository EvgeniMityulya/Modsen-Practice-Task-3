//
//  DemoBottomSheetViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class FilterBottomSheetViewController: BottomSheetViewController {
    
    // MARK: - UI
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private let stackSpacer1: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 203).isActive = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackSpacer2: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 292).isActive = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init and setup
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
    }
    
    private func setupView() {
        
        // Main content to be added in bottom sheet
        stackView.addArrangedSubview(
            filterByDateLabel,
            startDateLabel,
            startDateTextField,
            endDateLabel,
            endDateTextField,
            stackSpacer1,
            stackSpacer2,
            submitButton
        )
        
        stackSpacer1.isHidden = true
        stackSpacer2.isHidden = true
        
        self.setContent(content: stackView)


        
        
        
        startDatePickerContainerView.addSubview(startDatePicker)
        contentView.addSubview(startDatePickerContainerView)
        startDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            startDatePicker.topAnchor.constraint(equalTo: startDatePickerContainerView.topAnchor),
            startDatePicker.leadingAnchor.constraint(equalTo: startDatePickerContainerView.leadingAnchor),
            startDatePicker.trailingAnchor.constraint(equalTo: startDatePickerContainerView.trailingAnchor),
            startDatePicker.bottomAnchor.constraint(equalTo: startDatePickerContainerView.bottomAnchor),
            
            startDatePickerContainerView.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: 2),
            startDatePickerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            startDatePickerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            startDatePickerContainerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        endDatePickerContainerView.addSubview(endDatePicker)
        contentView.addSubview(endDatePickerContainerView)
        endDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            endDatePicker.topAnchor.constraint(equalTo: endDatePickerContainerView.topAnchor),
            endDatePicker.leadingAnchor.constraint(equalTo: endDatePickerContainerView.leadingAnchor),
            endDatePicker.trailingAnchor.constraint(equalTo: endDatePickerContainerView.trailingAnchor),
            endDatePicker.bottomAnchor.constraint(equalTo: endDatePickerContainerView.bottomAnchor),
            
            endDatePickerContainerView.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor, constant: 2),
            endDatePickerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            endDatePickerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            endDatePickerContainerView.heightAnchor.constraint(equalToConstant: 300)
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

    @objc private func handleDismissButton() {
        self.dismissBottomSheet()
    }
    
    @objc func startDatePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let selectedDate = dateFormatter.string(from: sender.date)
        startDateTextField.text = selectedDate
        toggleStartDate()
    }
    
    @objc func endDatePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let selectedDate = dateFormatter.string(from: sender.date)
        endDateTextField.text = selectedDate
        toggleEndDate()
    }
    
    @objc func openStartDatePicker() {
        if !endDatePickerContainerView.isHidden {
            toggleEndDate()
        }
        toggleStartDate()
    }
    
    @objc func openEndDatePicker() {
        if !startDatePickerContainerView.isHidden {
            toggleStartDate()
        }
        toggleEndDate()
    }
    
    private func toggleStartDate() {
        startDatePickerContainerView.isHidden.toggle()
        UIView.animate(withDuration: 0.3){
            self.stackSpacer1.isHidden.toggle()
        }
    }
    
    private func toggleEndDate() {
        endDatePickerContainerView.isHidden.toggle()
        UIView.animate(withDuration: 0.3){
            self.stackSpacer2.isHidden.toggle()
        }
    }
}
