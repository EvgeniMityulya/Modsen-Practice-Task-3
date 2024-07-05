//
//  BottomSheet.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    /// Maximum alpha for dimmed view
    private let maxDimmedAlpha: CGFloat = 0.3
    /// Minimum drag vertically that enable bottom sheet to dismiss
    private let minDismissiblePanHeight: CGFloat = 20
    /// Minimum spacing between the top edge and bottom sheet
    private var minTopSpacing: CGFloat = 80
    
    // MARK: - UI
    /// Main bottom sheet container view
     lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// View to to hold dynamic content
    public lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Top bar view that draggable to dismiss
    private lazy var topBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Top view bar
    private lazy var barLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Dimmed background view
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresent()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Container View
        view.addSubview(mainContainerView)
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainContainerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: minTopSpacing)
        ])
        
        // Top draggable bar view
        mainContainerView.addSubview(topBarView)
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 54)
        ])
        topBarView.addSubview(barLineView)
        NSLayoutConstraint.activate([
            barLineView.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            barLineView.topAnchor.constraint(equalTo: topBarView.topAnchor, constant: 8),
            barLineView.widthAnchor.constraint(equalToConstant: 40),
            barLineView.heightAnchor.constraint(equalToConstant: 6)
        ])
        
        // Content View
        mainContainerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDimmedView))
        dimmedView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        topBarView.addGestureRecognizer(panGesture)
    }

    @objc private func handleTapDimmedView() {
        dismissBottomSheet()
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // get drag direction
        let isDraggingDown = translation.y > 0
        guard isDraggingDown else { return }
        
        let pannedHeight = translation.y
        let currentY = self.view.frame.height - self.mainContainerView.frame.height
        // handle gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            self.mainContainerView.frame.origin.y = currentY + pannedHeight
        case .ended:
            // When user stop dragging
            // if fulfil the condition dismiss it, else move to original position
            if pannedHeight >= minDismissiblePanHeight {
                dismissBottomSheet()
            } else {
                self.mainContainerView.frame.origin.y = currentY
            }
        default:
            break
        }
    }

    private func animatePresent() {
        dimmedView.alpha = 0
        mainContainerView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.mainContainerView.transform = .identity
        }
        // Add more animation duration for smoothness
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {  [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.mainContainerView.frame.origin.y = self.view.frame.height
        }, completion: {  [weak self] _ in
            self?.dismiss(animated: false)
        })
    }
    
    // Subview controller will call this function to set content
    func setContent(content: UIView) {
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        view.layoutIfNeeded()
    }
}
