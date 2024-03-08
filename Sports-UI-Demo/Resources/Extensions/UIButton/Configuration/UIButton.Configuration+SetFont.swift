//
//  UIButton.Configuration+SetFont.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 08/03/2024.
//

import UIKit

extension UIButton.Configuration {
    mutating func setFont(_ font: UIFont) {
        titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { container in
            var container = container
            container.font = font
            
            return container
        }
    }
}
