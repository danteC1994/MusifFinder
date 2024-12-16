//
//  UIError.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 16/12/2024.
//

enum UIError: Error {
    case recoverableError(title: String, description: String, actionTitle: String)
    case nonRecoverableError(title: String, description: String, actionTitle: String)
}
