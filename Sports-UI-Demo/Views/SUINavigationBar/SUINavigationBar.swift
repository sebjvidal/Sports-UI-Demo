//
//  SUINavigationBar.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 08/03/2024.
//

import UIKit

class SUINavigationBar: UIView {
    private var visualEffectView: UIVisualEffectView!
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var separatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualEffectView()
        setupTitleLabel()
        setupDetailLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVisualEffectView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .systemMaterial)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 3),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupDetailLabel() {
        detailLabel = UILabel()
        detailLabel.text = "Subtitle"
        detailLabel.textColor = .secondaryLabel
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            detailLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSeparatorView() {
        separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.value(forKey: "_systemChromeShadowColor") as? UIColor
        
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0 / 3.0)
        ])
    }
}
