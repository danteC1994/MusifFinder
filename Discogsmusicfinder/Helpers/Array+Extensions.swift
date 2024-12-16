//
//  Array+Extensions.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 16/12/2024.
//

extension Array where Element: Identifiable {
    func removeDuplicateItems() -> Self {
        var seen = Set<Element.ID>()
        return self.filter { element in
            if seen.contains(element.id) {
                return false
            } else {
                seen.insert(element.id)
                return true
            }
        }
    }
}
