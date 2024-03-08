//
//  Comparable+ClampedTo.swift
//  Sports-UI-Demo
//
//  Created by Seb Vidal on 08/03/2024.
//

import Foundation

extension Comparable {
    func clamped(to limit: ClosedRange<Self>) -> Self {
        return min(max(self, limit.lowerBound), limit.upperBound)
    }
}
