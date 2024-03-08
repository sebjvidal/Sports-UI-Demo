//
//  SUIMainViewController.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 07/03/2024.
//

import UIKit

class SUIMainViewController: UIViewController {
    // MARK: - Private Properties
    private var gradientLayer: CAGradientLayer!
    private var titleLabel: UILabel!
    private var moreButton: UIButton!
    private var stackView: UIStackView!
    private var detailLabel: UILabel!
    private var getStartedButton: UIButton!
    private var featuredLabel: UILabel!
    private var containerView: UIView!
    
    // MARK: - init(nibName:bundle:)
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setupGradientLayer()
        setupTitleLabel()
        setupMoreButton()
        setupStackView()
        setupDetailLabel()
        setupGetStartedButton()
        setupFeaturedLabel()
        setupContainerView()
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor.sportsGreen, UIColor.black].map(\.cgColor)
        gradientLayer.locations = [0, 0.25]
        
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = " Sports"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupMoreButton() {
        moreButton = UIButton()
        moreButton.configuration = .filled()
        moreButton.configuration?.baseBackgroundColor = .tertiarySystemFill
        moreButton.configuration?.cornerStyle = .capsule
        moreButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 9)
        moreButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 10, bottom: 12, trailing: 10)
        moreButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(moreButton)
        
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 2),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 54),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let constants: [CGFloat] = [49, 60, 71, 82, 71, 60, 49]
        
        for constant in constants {
            let circleView = UIView()
            circleView.clipsToBounds = true
            circleView.layer.cornerCurve = .circular
            circleView.layer.cornerRadius = constant / 2
            circleView.backgroundColor = .tertiarySystemFill
            circleView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(circleView)
            
            NSLayoutConstraint.activate([
                circleView.widthAnchor.constraint(equalToConstant: constant),
                circleView.heightAnchor.constraint(equalToConstant: constant)
            ])
        }
    }
    
    private func setupDetailLabel() {
        detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .white
        detailLabel.textAlignment = .center
        detailLabel.font = .systemFont(ofSize: 17)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Choose your favourite leagues and teams."
        
        view.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupGetStartedButton() {
        getStartedButton = UIButton()
        getStartedButton.configuration = .filled()
        getStartedButton.configuration?.baseBackgroundColor = .white
        getStartedButton.configuration?.baseForegroundColor = .black
        getStartedButton.configuration?.buttonSize = .large
        getStartedButton.configuration?.cornerStyle = .large
        getStartedButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33)
        getStartedButton.configuration?.setFont(.systemFont(ofSize: 17, weight: .semibold))
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            getStartedButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 21),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupFeaturedLabel() {
        featuredLabel = UILabel()
        featuredLabel.textColor = .white
        featuredLabel.text = "Featured Games"
        featuredLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(featuredLabel)
        
        NSLayoutConstraint.activate([
            featuredLabel.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 54),
            featuredLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        for index in 0...4 {
            let button = UIButton()
            button.tag = index
            button.configuration = .filled()
            button.configuration?.baseBackgroundColor = .tertiarySystemFill
            button.configuration?.cornerStyle = .medium
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            containerView.addSubview(button)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let viewController = SUIDetailViewController()
        viewController.modalPresentationStyle = .custom
        viewController.currentPage = sender.tag
        
        present(viewController, animated: true)
    }
    
    private func layoutContainerViewSubviews() {
        for (index, subview) in containerView.subviews.enumerated() {
            let width = containerView.frame.width
            let height = (containerView.frame.height - 16) / 5
            let y = (height + 4) * CGFloat(index)
            subview.frame = CGRect(x: 0, y: y, width: width, height: height)
        }
    }
    
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContainerViewSubviews()
    }
}
