//
//  DemoBottomSheetViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func filterViewControllerDidSubmit(startDate: Date, endDate: Date)
}

class FilterViewController: BottomSheetViewController {
    
    // MARK: - Properties
    weak var delegate: FilterViewControllerDelegate?

    private var startDate: Date? {
        didSet {
            checkReadyToSubmit()
        }
    }
    private var endDate: Date? {
        didSet {
            checkReadyToSubmit()
        }
    }
    private var isReadyToSubmit: Bool = false
        
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
    
    private let startDateLabel = TextLabel(with: "Start date")
    private let startDateTextField = CustomTextField(with: "Select start date")
    
    private let endDateLabel = TextLabel(with: "End date")
    private let endDateTextField = CustomTextField(with: "Select end date")
    
    private let submitButton = SolidButton(with: "Submit")
    
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
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTargets()
    }

    // MARK: - Selectors
    @objc func doFilter() {
        if startDate == nil {
            startDateTextField.setRedBorder()
        }
        if endDate == nil {
            endDateTextField.setRedBorder()
        }
        if isReadyToSubmit {
            delegate?.filterViewControllerDidSubmit(startDate: startDate!, endDate: endDate!)
            dismissBottomSheet()
        }
    }

    @objc private func handleDismissButton() {
        self.dismissBottomSheet()
    }
    
    @objc func startDatePickerValueChanged(sender: UIDatePicker) {
        startDateTextField.text = sender.date.toString()
        startDate = sender.date
        toggleStartDate()
    }
    
    @objc func endDatePickerValueChanged(sender: UIDatePicker) {
        endDateTextField.text = sender.date.toString()
        endDate = sender.date
        toggleEndDate()
    }
    
    @objc func openStartDatePicker() {
        startDateTextField.setWhiteBorder()
        endDateTextField.setWhiteBorder()
        if !endDatePickerContainerView.isHidden {
            toggleEndDate()
        }
        toggleStartDate()
    }
    
    @objc func openEndDatePicker() {
        startDateTextField.setWhiteBorder()
        endDateTextField.setWhiteBorder()
        if !startDatePickerContainerView.isHidden {
            toggleStartDate()
        }
        toggleEndDate()
    }
    
    // MARK: - Methods
    private func checkReadyToSubmit() {
        if startDate != nil && endDate != nil {
            if startDate! > endDate! {
                isReadyToSubmit = false
                startDateTextField.setRedBorder()
                endDateTextField.setRedBorder()
                submitButton.setInactive()
            } else {
                isReadyToSubmit = true
                submitButton.setActive()
            }
        } else {
            isReadyToSubmit = false
            submitButton.setInactive()
        }
    }
    
    private func toggleStartDate() {
        startDatePickerContainerView.isHidden.toggle()
        UIView.animate(withDuration: 0.3){
            self.toggleStartSpacing()
        }
    }
    
    private func toggleEndDate() {
        endDatePickerContainerView.isHidden.toggle()
        UIView.animate(withDuration: 0.3){
            self.toggleEndSpacing()
        }
    }
    
    private func toggleStartSpacing() {
        if startDatePickerContainerView.isHidden == true {
            self.stackView.setCustomSpacing(20, after: self.startDateTextField)
        } else {
            self.stackView.setCustomSpacing(216, after: self.startDateTextField)
        }
    }
    
    private func toggleEndSpacing() {
        if endDatePickerContainerView.isHidden == true {
            self.stackView.setCustomSpacing(20, after: self.endDateTextField)
        } else {
            self.stackView.setCustomSpacing(302, after: self.endDateTextField)
        }
    }
}

private extension FilterViewController {
    func setupTargets() {
        
        submitButton.addTarget(self, action: #selector(doFilter), for: .touchUpInside)
        
        let startDateCalendarButton = IconButton(buttonType: .calendar)
        startDateCalendarButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        startDateCalendarButton.addTarget(self, action: #selector(openStartDatePicker), for: .touchUpInside)
        
        let startDateContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        startDateCalendarButton.center = CGPoint(x: startDateContainerView.frame.size.width - 16, y: startDateContainerView.frame.size.height / 2)
        startDateContainerView.addSubview(startDateCalendarButton)
        
        startDateTextField.rightView = startDateContainerView
        startDateTextField.rightViewMode = .always
        
        let endDateCalendarButton = IconButton(buttonType: .calendar)
        endDateCalendarButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        endDateCalendarButton.addTarget(self, action: #selector(openEndDatePicker), for: .touchUpInside)
        
        let endDateContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        endDateCalendarButton.center = CGPoint(x: endDateContainerView.frame.size.width - 16, y: endDateContainerView.frame.size.height / 2)
        endDateContainerView.addSubview(endDateCalendarButton)
        
        endDateTextField.rightView = endDateContainerView
        endDateTextField.rightViewMode = .always
    }
    
    private func setupUI() {
        submitButton.setInactive()
        
        stackView.addArrangedSubview(
            filterByDateLabel,
            startDateLabel,
            startDateTextField,
            endDateLabel,
            endDateTextField,
            submitButton
        )
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        startDatePickerContainerView.addSubview(startDatePicker)
        contentView.addSubview(startDatePickerContainerView)
        startDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            startDatePicker.topAnchor.constraint(equalTo: startDatePickerContainerView.topAnchor),
            startDatePicker.leadingAnchor.constraint(equalTo: startDatePickerContainerView.leadingAnchor),
            startDatePicker.trailingAnchor.constraint(equalTo: startDatePickerContainerView.trailingAnchor),
            startDatePicker.bottomAnchor.constraint(equalTo: startDatePickerContainerView.bottomAnchor),
            
            startDatePickerContainerView.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: 2),
            startDatePickerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            startDatePickerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            startDatePickerContainerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        endDatePickerContainerView.addSubview(endDatePicker)
        contentView.addSubview(endDatePickerContainerView)
        endDatePickerContainerView.isHidden = true
        NSLayoutConstraint.activate([
            endDatePicker.topAnchor.constraint(equalTo: endDatePickerContainerView.topAnchor),
            endDatePicker.bottomAnchor.constraint(equalTo: endDatePickerContainerView.bottomAnchor),
            endDatePicker.leadingAnchor.constraint(equalTo: endDatePickerContainerView.leadingAnchor),
            endDatePicker.trailingAnchor.constraint(equalTo: endDatePickerContainerView.trailingAnchor),
            
            endDatePickerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            endDatePickerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            endDatePickerContainerView.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor),
            endDatePickerContainerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
