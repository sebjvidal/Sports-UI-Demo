//
//  SUIDetailViewController.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 07/03/2024.
//

import UIKit

class SUIDetailViewController: UIViewController, UIScrollViewDelegate, SUICardViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Properties
    private var titleLabel: UILabel!
    private var scrollView: UIScrollView!
    private var cardViews: [SUICardView] = []
    
    private var horizontalPagePadding: CGFloat = 20
    private var interPageSpacing: CGFloat = 10
    private var _currentPage: Int = 0
    
    // MARK: - Public Properties
    var currentPage: Int {
        get {
            return _currentPage
        } set {
            _currentPage = newValue
            updateScrollViewCurrentPage()
        }
    }
    
    // MARK: - init(nibName:bundle:)
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setupViewController()
        setupTitleLabel()
        setupScrollView()
        setupCardViews()
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupViewController() {
        view.backgroundColor = .black.withAlphaComponent(0.9)
        transitioningDelegate = self
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Today"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.decelerationRate = .fast
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset.left = horizontalPagePadding
        scrollView.contentInset.right = horizontalPagePadding
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCardViews() {
        for index in 1...5 {
            let cardView = SUICardView()
            cardView.delegate = self
            cardView.image = UIImage(named: "\(index)")
            
            cardViews.append(cardView)
            scrollView.addSubview(cardView)
        }
    }
    
    private func updateCardViewInsets() {
        for cardView in cardViews where cardView.contentInset.top == 0 {
            let inset = titleLabel.frame.maxY - view.safeAreaInsets.top + 17
            cardView.contentInset.top = inset
        }
    }
    
    private func layoutScrollViewSubviews(fullscreenFraction: CGFloat = 0) {
        let horizontalOffset = horizontalPagePadding * fullscreenFraction
        let additionalWidth = (horizontalOffset * 2)
        let commonWidth = view.frame.width - (horizontalPagePadding * 2)
        let commonHeight = view.frame.height - scrollView.contentInset.top
        
        for (index, subview) in cardViews.enumerated() {
            if index == _currentPage {
                let index = CGFloat(index)
                let x = (commonWidth + 10) * index - horizontalOffset
                let width = commonWidth + additionalWidth
                subview.frame = CGRect(x: x, y: 0, width: width, height: commonHeight)
            } else if index < _currentPage {
                let x = (commonWidth + 10) * CGFloat(index) - (horizontalOffset)
                subview.frame = CGRect(x: x, y: 0, width: commonWidth, height: commonHeight)
            } else {
                let x = cardViews[index - 1].frame.maxX + interPageSpacing
                subview.frame = CGRect(x: x, y: 0, width: commonWidth, height: commonHeight)
            }
        }
    }
    
    private func updateScrollViewContentSize() {
        let width = cardViews[cardViews.count - 1].frame.maxX
        let height = scrollView.frame.height - scrollView.contentInset.top
        scrollView.contentSize = CGSize(width: width, height: height)
    }
    
    private func setCardViewsEnabled(_ enabled: Bool, except cardViewException: SUICardView) {
        for cardView in cardViews where cardView != cardViewException {
            cardView.isUserInteractionEnabled = enabled
        }
    }
    
    private func setHorizontalScrollEnabled(_ enabled: Bool) {
        scrollView.isScrollEnabled = enabled
    }
    
    private func updateScrollViewCurrentPage() {
        let width = view.frame.width - horizontalPagePadding - interPageSpacing
        let inset = scrollView.contentInset.left
        scrollView.contentOffset.x = width * CGFloat(currentPage) - inset
    }
    
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCardViewInsets()
        layoutScrollViewSubviews()
        updateScrollViewContentSize()
        updateScrollViewCurrentPage()
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = view.frame.width - (horizontalPagePadding * 2) + interPageSpacing
        let approximatePage = (scrollView.contentOffset.x + scrollView.contentInset.left) / pageWidth
        let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))
        let clampedPage = currentPage.clamped(to: 0...CGFloat(cardViews.count - 1))
        _currentPage = Int(clampedPage)
        
        targetContentOffset.pointee.x = pageWidth * clampedPage - scrollView.contentInset.left
    }
    
    // MARK: - CardViewDelegate
    func cardView(_ cardView: SUICardView, scrollViewDidScroll scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let inset = scrollView.contentInset.top + view.safeAreaInsets.top
        let fraction = ((offset + inset) / inset).clamped(to: 0...1)
        setCardViewsEnabled(fraction == 0, except: cardView)
        setHorizontalScrollEnabled(fraction == 0)
        layoutScrollViewSubviews(fullscreenFraction: fraction)
    }
    
    func cardView(_ cardView: SUICardView, didRequestDismissal scrollView: UIScrollView) {
        dismiss(animated: true)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionContext.viewController(forKey: .to) == self {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        let destination = transitionContext.viewController(forKey: .to) as! SUIDetailViewController
        destination.scrollView.alpha = 0
        destination.view.alpha = 0
        
        let transitionView = SUIDetailViewController()
        transitionView.view.layoutIfNeeded()
        transitionView.currentPage = destination.currentPage
        transitionView.titleLabel.isHidden = true
        transitionView.view.backgroundColor = .clear
        transitionView.view.frame.origin.y = destination.view.frame.height
        
        let containerView = transitionContext.containerView
        containerView.addSubview(destination.view)
        containerView.addSubview(transitionView.view)
        
        let animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 1) {
            destination.view.alpha = 1
            transitionView.view.frame = containerView.frame
        }
        
        animator.addCompletion { position in
            destination.scrollView.alpha = 1
            transitionView.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    
    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        let origin = transitionContext.viewController(forKey: .from) as! SUIDetailViewController
        origin.scrollView.alpha = 0
        
        let inset = origin.cardViews[origin._currentPage].contentInset.top
        let offset = origin.cardViews[origin._currentPage].contentOffset.y
        let value = inset + offset
        
        let transitionView = SUIDetailViewController()
        transitionView.currentPage = origin.currentPage
        transitionView.titleLabel.isHidden = true
        transitionView.view.backgroundColor = .clear
        transitionView.view.frame = origin.view.frame
        transitionView.additionalSafeAreaInsets = origin.view.safeAreaInsets
        transitionView.cardViews[origin._currentPage].contentInset.top = -value
        transitionView.cardViews[origin._currentPage].contentOffset.y = value
        transitionView.scrollView.contentOffset = origin.scrollView.contentOffset
        
        let containerView = transitionContext.containerView
        containerView.addSubview(origin.view)
        containerView.addSubview(transitionView.view)
        
        let animator = UIViewPropertyAnimator(duration: 0.35, dampingRatio: 1) {
            origin.view.alpha = 0
            transitionView.view.frame.origin.y = containerView.frame.height
        }
        
        animator.addCompletion { position in
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
}
