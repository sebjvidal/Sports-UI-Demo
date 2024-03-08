//
//  SUICardViewDelegate.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 08/03/2024.
//

import UIKit

protocol SUICardViewDelegate: NSObject {
    func cardView(_ cardView: SUICardView, scrollViewDidScroll scrollView: UIScrollView)
    func cardView(_ cardView: SUICardView, didRequestDismissal scrollView: UIScrollView)
}
