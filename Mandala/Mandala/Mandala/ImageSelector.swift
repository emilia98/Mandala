//
//  ImageSelector.swift
//  Mandala
//
//  Created by Emilia Nedyalkova on 6.05.21.
//

import UIKit

class ImageSelector: UIControl {
    private(set) var selectedIndex = 0 {
        didSet {
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
            
            let imageButton = imageButtons[selectedIndex]
            highlightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
        }
    }
    
    var highlightColors: [UIColor] = [] {
        didSet {
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
        }
    }
    
    private var imageButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach {
                $0.removeFromSuperview()
            }
            imageButtons.forEach {
                selectorStackView.addArrangedSubview($0)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2.0
    }
    
    var images: [UIImage] = [] {
        didSet {
            var buttonId = 0
            
            imageButtons = images.map { image in
                let imageButton = UIButton()
                
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self,
                                      action: #selector(imageButtonTapped(_:)),
                                      for: .touchUpInside)
                imageButton.tag = buttonId
                buttonId += 1
                
                return imageButton
            }
            
            selectedIndex = 0
        }
    }
    
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private func highlightColor(forIndex index: Int) -> UIColor {
        guard index >= 0 && index < highlightColors.count else {
            return UIColor.blue.withAlphaComponent(0.6)
        }
        
        return highlightColors[index]
    }
    
    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewHierarchy()
    }
    
    private func configureViewHierarchy() {
        self.addSubview(selectorStackView)
        self.insertSubview(highlightView, belowSubview: selectorStackView)
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
            highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
        ])
    }
    
    @objc
    private func imageButtonTapped(_ sender: UIButton) {
        let selectionAnimator = UIViewPropertyAnimator(
            duration: 1,
            curve: .easeInOut,
            animations: {
                self.selectedIndex = sender.tag
                self.layoutIfNeeded()
        })
        selectionAnimator.startAnimation()
        
        sendActions(for: .valueChanged)
    }
}
