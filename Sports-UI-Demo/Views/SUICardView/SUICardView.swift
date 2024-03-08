//
//  SUICardView.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 08/03/2024.
//

import UIKit

class SUICardView: UIView, UIScrollViewDelegate {
    // MARK: - Private Properties
    private var scrollView: UIScrollView!
    private var backgroundView: UIImageView!
    private var navigationBar: SUINavigationBar!
    
    // MARK: - Public Properties
    var contentInset: UIEdgeInsets {
        get {
            return scrollView.contentInset
        } set {
            scrollView.contentInset = newValue
            scrollView.contentOffset.y = -newValue.top
        }
    }
    
    var contentOffset: CGPoint {
        get {
            return scrollView.contentOffset
        } set {
            scrollView.contentOffset = newValue
        }
    }
    
    weak var delegate: SUICardViewDelegate? = nil
    
    var image: UIImage? {
        get {
            return backgroundView.image
        } set {
            backgroundView.image = newValue
        }
    }
    
    // MARK: - init(frame:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupBackgroundView()
        setupNavigationBar()
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize.height = 2000
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.decelerationRate = .fast
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupBackgroundView() {
        backgroundView = UIImageView()
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 12
        backgroundView.layer.cornerCurve = .continuous
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.backgroundColor = .black
        
        scrollView.addSubview(backgroundView)
    }
    
    private func setupNavigationBar() {
        navigationBar = SUINavigationBar()
        
        addSubview(navigationBar)
    }
    
    private func layoutBackgroundView() {
        backgroundView.frame.size.width = frame.width
        backgroundView.frame.size.height = scrollView.contentSize.height + scrollView.contentInset.top
    }
    
    private func layoutNavigationBar() {
        let width = frame.width
        let height = safeAreaInsets.top + 49
        navigationBar.frame.size = CGSize(width: width, height: height)
        
        let offset = scrollView.contentOffset.y.clamped(to: 0...height)
        let fraction = offset / height
        let y = min(0, -height + scrollView.contentOffset.y)
        navigationBar.frame.origin.y = y
        navigationBar.alpha = 1 * fraction
    }
    
    // MARK: - layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundView()
        layoutNavigationBar()
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.cardView(self, scrollViewDidScroll: scrollView)
        layoutNavigationBar()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let inset = scrollView.contentInset.top + safeAreaInsets.top
        let offset = scrollView.contentOffset.y + inset
        
        if offset < -64 { delegate?.cardView(self, didRequestDismissal: scrollView) }
    }
}
